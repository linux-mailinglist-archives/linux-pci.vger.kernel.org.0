Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D091721AE5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 00:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjFDWuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 18:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 18:50:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E74DD3;
        Sun,  4 Jun 2023 15:50:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b5881734so5150310e87.0;
        Sun, 04 Jun 2023 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685919040; x=1688511040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJwPRTwaUr2TZRzE6A7VxF+Vzo4yDjm2AO9GVcS91bg=;
        b=MyaPvhQiZN1WXRacRGISQXvtk6jeuOHhyVfLDYz1Zy12WtW0rWStLnYGscuVM4gewD
         qamlf0aD2OTtzqsSF8ZB6bfkvriJ7rYXuTsh53y/AVsrwfD7vaOVrWANGyyuQoR7jvRv
         jcLMvPE/xnwy1wp/tB03xncLbi387XayHaZIL6jLmHzQPNX/vCe7NeDqV8PDmYwQrYSa
         1gNvCYqbnpj9oXAiCqyXG6/4j8HgRn1tGme9x2Ba5qmg6X1ZXWuej4tmxOV1BIqq0XOY
         ZEAoSjTlkUzTiZO/75BspbvU0nnGEnelGAyfglVCVzWvW+VCdY4c21R3bxT6Ad9NrLWh
         LZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685919040; x=1688511040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJwPRTwaUr2TZRzE6A7VxF+Vzo4yDjm2AO9GVcS91bg=;
        b=WninH9oAML0hwDdGG1HzPs9rm7mFJ8TKsc29YtFCDlS7WxzF2VGtY7eCcz8SDH4nyx
         3gcdCX7ojDRzJZ1FOIjLJO9uuiZC8BQS5iLl+uhlf6ai26d/rGCA2jnwa3jg5KP3qA1E
         cDbdPJAK4Kc1PlLXIV4JLdJhlF+RB2lqePIUeVuy2rn2ht561lj6FZn1aw0goQToiUG+
         U2TQml8IMGWYjpLX+xmVIws7llDJZn+yV7PaA3qzZPeMyFeub4uTQtz16m/9ohYD6lx8
         q1ywU95hb69F8g46xwwsV3hv3ipFFZgIw3ejCOEFQrbxHxcva1AIT+xQdhMvvEzhRdNQ
         chpQ==
X-Gm-Message-State: AC+VfDx+RUdTa0Xu4nH6xnWcH9cmJZgTih5U2WdadzdsszKwdFiRIaTD
        eexllWJlgQkhf9z+pvOEnBg=
X-Google-Smtp-Source: ACHHUZ6mCMVY9k8TPPRIZmBDlVFGt1XfTafbxf775H8qbC01AA/rbIJdsxIpQUpKuHnml8ekox++/A==
X-Received: by 2002:ac2:52b4:0:b0:4f4:dfd4:33df with SMTP id r20-20020ac252b4000000b004f4dfd433dfmr3971595lfm.21.1685919039989;
        Sun, 04 Jun 2023 15:50:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id w2-20020ac254a2000000b004f60e0ecc7dsm904803lfk.250.2023.06.04.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 15:50:39 -0700 (PDT)
Date:   Mon, 5 Jun 2023 01:50:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 01/22] PCI: Add PCI_EXP_LNKCAP_MLW macros
Message-ID: <20230604225036.earzdx5dvzc3imoz@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-2-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:13PM +0900, Yoshihiro Shimoda wrote:
> Add macros defining Maximum Link Width bits in Link Capabilities
> Register.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

You haven't been using these macros in the following up patches since
v9. Why do you keep submitting this change then? I would suggest to
drop the patch especially seeing the PCI_EXP_LNKCAP_MLW field directly
encodes the link width thus these macros unlikely will be of much use.

-Serge(y)

> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index dc2000e0fe3a..5d48413ac28f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -538,6 +538,12 @@
>  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
>  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
>  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
> +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1 */
> +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2 */
> +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4 */
> +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8 */
> +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x12 */
> +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x16 */
>  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
> -- 
> 2.25.1
> 
