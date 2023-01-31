Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79568207A
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 01:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAaAQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 19:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAaAQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 19:16:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB5210D2
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 16:16:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A689B818BD
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 00:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E5C433EF;
        Tue, 31 Jan 2023 00:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675124163;
        bh=w3Cnt774xJ3P+XOedhRAKmsTJiNLq8Xu09PTYWuiWMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b3Jd2t7qcpvu8UxjtrhQzKmp9UfZat+tsh0xYtVRagpSMb1W+9lXWSZzKf/+jfLCf
         zkF4cUPr36zayP9QCbhCFKWKqWhhiI4qQnu27hK5y+Xz873A5qJWu+mnXaeHmT/For
         uXbU/UgK3MF98zZ9Xk2j4h3KFKnnDQFQ99lGdvo7FiLuzHPLosanuFJ30WcRDfuUgX
         anW7eWq0hj/CFJQDzbDS0e826p2pUf9YlVLRlUipdVtlSgCoZt0Iiqp04kfKmJkMLL
         701ADJxLYrzGRX894ZGk296K8RCVFaaf7PfAqH+b1FY6Bb96oRc+5399JEh6aLfICq
         jQuE2tiCHK2dg==
Date:   Mon, 30 Jan 2023 18:16:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        HougeLangley <hougelangley1987@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH V2 1/2] PCI: loongson: Improve the MRRS quirk for LS7A
Message-ID: <20230131001601.GA1718721@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106095143.3158998-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 06, 2023 at 05:51:42PM +0800, Huacai Chen wrote:
> In new revision of LS7A, some PCIe ports support larger value than 256,
> but their maximum supported MRRS values are not detectable. Moreover,
> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> will actually set a big value in its driver. So the only possible way
> is configure MRRS of all devices in BIOS, and add a pci host bridge bit
> flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> 
> However, according to PCIe Spec, it is legal for an OS to program any
> value for MRRS, and it is also legal for an endpoint to generate a Read
> Request with any size up to its MRRS. As the hardware engineers say, the
> root cause here is LS7A doesn't break up large read requests. In detail,
> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> request with a size that's "too big" ("too big" means larger than the
> PCIe ports can handle, which means 256 for some ports and 4096 for the
> others, and of course this is a problem in the LS7A's hardware design).

Can you take a look at
https://bugzilla.kernel.org/show_bug.cgi?id=216884 ?

That claims to be a regression between v6.1 and v6.2-rc2, and WANG
Xuerui says this patch is the fix (though AFAICT the submitter has not
verified this yet).  If so, we should reference that bug here and try
to get this in v6.2.

See below.

> -		if (pci_match_id(bridge_devids, bridge)) {
> -			if (pcie_get_readrq(dev) > 256) {
> -				pci_info(dev, "limiting MRRS to 256\n");
> -				pcie_set_readrq(dev, 256);
> -			}
> -			break;
> -		}

> +	if (bridge->no_inc_mrrs) {
> +		if (rq > pcie_get_readrq(dev))
> +			return -EINVAL;

I think the message about limiting MRRS was useful and we should keep
it.

Bjorn
