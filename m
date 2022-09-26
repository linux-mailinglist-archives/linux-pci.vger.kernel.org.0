Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED255EAE78
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiIZRsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 13:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIZRrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 13:47:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216BB91D18;
        Mon, 26 Sep 2022 10:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 818DDB80B77;
        Mon, 26 Sep 2022 17:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC71BC433C1;
        Mon, 26 Sep 2022 17:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664212739;
        bh=n6sI+gJdX1CXKGOEvonlIpKq6IP4Kh1davub/DjLnCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MtFY3CVsZCIR9NETkaPyL76VrSk+x+ET0f2tDeRd+vc+asQFAEyXL5eIQsbO2PQd5
         h+MBhLzPkX7Jx31mXa1JDJaF56wfJVjZ/yD+U7G8DKsMNcd45XuEhmkIw+vb160h9e
         ERvtEsRMXQRqiwVSOJSOBAOfQ1aVthq4cy2PIxJb6DiFVunMyduO/FG8qJWwrpwk0/
         sporJS/kZz1YkrkQujZfbKFyj0ZikcNDQDm3uYysvxTgludNAWg2H0Jy6F9Jp/Fjmh
         hixmYrj3nDsyag1NNMpz36iQsIou7IrvvV7VW4KmhFzn4TPMpblRS3hQRlONghXsJK
         Z4g3Q/zV5JiWA==
Date:   Mon, 26 Sep 2022 12:18:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20220926171857.GA1609097@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89efd20f-65f2-c082-1eb4-4e308957ff59@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 09:31:34PM +0800, Shuai Xue wrote:
> 在 2022/9/23 PM11:54, Jonathan Cameron 写道:
> >> I found a similar definition in arch/ia64/pci/pci.c .
> >>
> >> 	#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)		\
> >> 	(((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))
> >>
> >> Should we move it into a common header first?
> > 
> > Maybe. The bus, devfn, reg part is standard bdf, but I don't think
> > the PCI 6.0 spec defined a version with the seg in the upper bits.
> > I'm not sure if we want to adopt that in LInux.
> 
> I found lots of code use seg,bus,devfn,reg with format "%04x:%02x:%02x.%x",
> I am not quite familiar with PCIe spec. What do you think about it, Bjorn?

The PCIe spec defines an address encoding for bus/device/function/reg
for the purposes of ECAM (PCIe r6.0, sec 7.2.2), but as far as I know,
it doesn't define anything similar that includes the segment.  The
segment is really outside the scope of PCIe because each segment is a
completely separate PCIe hierarchy.

So I probably wouldn't make this a generic definition.  But if/when
you print things like this out, please do use the format spec you
mentioned above so it matches the style used elsewhere.

Bjorn
