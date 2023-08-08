Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEE774D53
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjHHVs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjHHVsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:48:14 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E61CEA5;
        Tue,  8 Aug 2023 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=9sVX9BvFPnR6ajSwDaIBsOtrzD17lklAlKdcnkookpA=; b=jW+ArCMsUgOXYfZJ8oy3p1HqQ+
        f3JK5Xf4z1pq/mwvsOI0BmVfXEk5iWiSxMpvxcFKBN0rpLoIEfrPxJSYyElM3/gcjKdVket8eqIrC
        xi/sGHG91hFyGsuNCbFfv3/UJfXcjFF+6Y6fPhEDJZUTdLhiF4qyHprgqiiUyKbCg7Go=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:40076 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qTQK1-00010f-Vm; Tue, 08 Aug 2023 13:16:42 -0400
Date:   Tue, 8 Aug 2023 13:16:41 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>
Message-Id: <20230808131641.ebafb9e042c7463e55c7fb00@hugovil.com>
In-Reply-To: <20230808103733.93707-3-thippeswamy.havalige@amd.com>
References: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
        <20230808103733.93707-3-thippeswamy.havalige@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-nwl: Modify ECAM size
 in example.
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Aug 2023 16:07:32 +0530
Thippeswamy Havalige <thippeswamy.havalige@amd.com> wrote:

Hi,
drop the final dot in all commit titles.

Hugo Villeneuve.


> Update ECAM size in example to discover up to 256 buses.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v2:
> None.
> changes in v1:
> None.
> ---
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> index 8976025..426f90a 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -118,7 +118,7 @@ examples:
>              compatible = "xlnx,nwl-pcie-2.11";
>              reg = <0x0 0xfd0e0000 0x0 0x1000>,
>                    <0x0 0xfd480000 0x0 0x1000>,
> -                  <0x80 0x00000000 0x0 0x1000000>;
> +                  <0x80 0x00000000 0x0 0x10000000>;
>              reg-names = "breg", "pcireg", "cfg";
>              ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
>                       <0x43000000 0x00000006 0x0 0x00000006 0x0 0x00000002 0x0>;
> -- 
> 1.8.3.1
> 
