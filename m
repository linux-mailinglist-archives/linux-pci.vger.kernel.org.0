Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4272B915
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjFLHuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjFLHtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 03:49:15 -0400
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 00:48:48 PDT
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:101:465::204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42110E2
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 00:48:48 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Qfk4N5jGyz9sQw;
        Mon, 12 Jun 2023 09:35:32 +0200 (CEST)
Message-ID: <c8cc05fd-96f3-36a9-c481-d00ed99a876c@denx.de>
Date:   Mon, 12 Jun 2023 09:35:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] Documentation: PCI: Update cross references to
 .rst files
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230609222500.1267795-1-helgaas@kernel.org>
 <20230609222500.1267795-4-helgaas@kernel.org>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20230609222500.1267795-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Qfk4N5jGyz9sQw
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/10/23 00:24, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Change references to *.txt to *.rst to match the current filenames.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   Documentation/PCI/pci-error-recovery.rst | 2 +-
>   Documentation/PCI/pcieaer-howto.rst      | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 9981d330da8f..c237596f67e3 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -364,7 +364,7 @@ Note, however, not all failures are truly "permanent". Some are
>   caused by over-heating, some by a poorly seated card. Many
>   PCI error events are caused by software bugs, e.g. DMA's to
>   wild addresses or bogus split transactions due to programming
> -errors. See the discussion in powerpc/eeh-pci-error-recovery.txt
> +errors. See the discussion in Documentation/powerpc/eeh-pci-error-recovery.rst
>   for additional detail on real-life experience of the causes of
>   software errors.
>   
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index c98a229ea9f5..3f91d54af770 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -160,8 +160,8 @@ when performing error recovery actions.
>   Data struct pci_driver has a pointer, err_handler, to point to
>   pci_error_handlers who consists of a couple of callback function
>   pointers. AER driver follows the rules defined in
> -pci-error-recovery.txt except pci express specific parts (e.g.
> -reset_link). Pls. refer to pci-error-recovery.txt for detailed
> +pci-error-recovery.rst except pci express specific parts (e.g.
> +reset_link). Pls. refer to pci-error-recovery.rst for detailed
>   definitions of the callbacks.
>   
>   Below sections specify when to call the error callback functions.

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
