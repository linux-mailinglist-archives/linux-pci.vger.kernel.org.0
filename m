Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73023721B35
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 02:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFEAZl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 20:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEAZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 20:25:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94FFCC;
        Sun,  4 Jun 2023 17:25:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1b2ca09b9so28828391fa.1;
        Sun, 04 Jun 2023 17:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685924738; x=1688516738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYlRYy9MgXWGQls9ZmzboJnmu32FmhCrTKxHUsegk54=;
        b=CZncJxEGwanzEim8+FL0s+TwNpFtd35nfqdPQRhRmoI8gCtUZVFtxbe6kS0RBY1e/m
         PJWwLoZ/PGu/Y4U1SBvseizZHzxF4J4GIKssAALWhrkKlrNhhK+pksh6MOC9YhzTbXe6
         YzuxuQ3tYE1Z0P+T1rKO649YFennetHAcKWI27wyYGINGBCawaaeOhBLXWNnvZMvOupr
         HnIhaeoLLPEIz9/gZdZvVJRtftdcOJYFE7QDt9j25CFzSclFYBukIdBOH4kpa5PbjDCk
         CTRj4iVDjtag7aEMT+ITof1iBkgU2Nau302oBAl3Lnoh3rxaVQg2zve2T2eSe2rnauyM
         ylEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685924738; x=1688516738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYlRYy9MgXWGQls9ZmzboJnmu32FmhCrTKxHUsegk54=;
        b=hktWl/trinJDOnuvDAgA/utMAf32vG5+3JTlyYIdVRylOTGnyhqFfhbdv8p+MXQZYB
         l+68WzREOkRfUNNkI2fd4CjoPnr4mDI+bv9c6PBssxuOHPGBdoXN1sGfJeeTUwECwMbj
         VyYXOSUzEN3UosPRS+k8IPkyL7wCg+by7B91iUJrclMu+pIWBBjmnOY9/ULwodrL+Vye
         SEY/2PMb0CAFEy6QV0XVP3/MV4kbemvJnjgr5hnUAtBOMaOFglNuhDYqDDmmFEPQ3Y5c
         ePaivG1l9gcowQ5cqobpqUa7fRAgcPJd4IX6LYsTREXQYLFIjScJxPZTkllwNoH+rvM7
         EQRw==
X-Gm-Message-State: AC+VfDwiR+BQGY/re1eK5C5/8n+M65UEqQ5Yws4w4djETkpqRhdVUzmw
        Twm6EF4pliMDz1+ImPVQ238FZRyllknDqA==
X-Google-Smtp-Source: ACHHUZ4fxfoLaXaswLh917fs58Sed/QKxIibrCyOG1N/6mg6OehD5KT7PM5pNLcVbN26g8a+0o3rcg==
X-Received: by 2002:a05:651c:8a:b0:2b1:c665:329d with SMTP id 10-20020a05651c008a00b002b1c665329dmr1086574ljq.35.1685924737903;
        Sun, 04 Jun 2023 17:25:37 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id j4-20020a2eb704000000b002adaacdb900sm1224320ljo.42.2023.06.04.17.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 17:25:37 -0700 (PDT)
Date:   Mon, 5 Jun 2023 03:25:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v16 01/22] PCI: Add PCI_EXP_LNKCAP_MLW macros
Message-ID: <20230605002535.f75gn32artzoyiat@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-2-yoshihiro.shimoda.uh@renesas.com>
 <20230604225036.earzdx5dvzc3imoz@mobilestation>
 <TYBPR01MB534183482CD31D122C4735C0D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB534183482CD31D122C4735C0D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 05, 2023 at 12:14:26AM +0000, Yoshihiro Shimoda wrote:
> Hello Serge,
> 
> > From: Serge Semin, Sent: Monday, June 5, 2023 7:51 AM
> > 
> > On Wed, May 10, 2023 at 03:22:13PM +0900, Yoshihiro Shimoda wrote:
> > > Add macros defining Maximum Link Width bits in Link Capabilities
> > > Register.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > You haven't been using these macros in the following up patches since
> > v9. Why do you keep submitting this change then? I would suggest to
> > drop the patch especially seeing the PCI_EXP_LNKCAP_MLW field directly
> > encodes the link width thus these macros unlikely will be of much use.
> 
> Thank you for your review! You're correct. I didn't realized that
> the macros were not used on the patch series..
> 
> However, I also realized that the patch 11/22 used the PCI_EXP_LNKSTA_NLW_SHIFT
> macro for the PCI_EXP_LNKCAP register. So, I'm thinking that I should modify
> this patch as adding PCI_EXP_LNKCAP_MLW_SHIFT instead. But, what do you think?
> 
> --- on the patch 11/22 ---
> > +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	val = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > +	val &= ~PCI_EXP_LNKCAP_MLW;
> > +	val |= num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
> 
> Perhaps, this should be PCI_EXP_LNKCAP_MLW_SHIFT instead.

I'll get to that patch tomorrow, but in any case there is no need in
defining an additional macro here. There is a handy helper FIELD_PREP()
for that: FIELD_PREP(PCI_EXP_LNKSTA_MLW, num_lanes).

IMO for the same reason the PCI_EXP_LNKSTA_NLW_* macros are
unnecessary and can be easily either dropped or replaced by the
FIELD_{PREP,GET} macros usage.

-Serge(y)

> ---
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > > ---
> > >  include/uapi/linux/pci_regs.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index dc2000e0fe3a..5d48413ac28f 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -538,6 +538,12 @@
> > >  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
> > >  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
> > >  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x12 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x16 */
> > >  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
> > >  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
> > >  #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
> > > --
> > > 2.25.1
> > >
