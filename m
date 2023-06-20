Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7F736C06
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 14:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjFTMgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTMgR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 08:36:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E2310FA;
        Tue, 20 Jun 2023 05:36:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f769c37d26so6106694e87.1;
        Tue, 20 Jun 2023 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687264570; x=1689856570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWBDXIcglRuVtZI8959sIG7iLkywrHbYxE58IPCNYGE=;
        b=ZyvPlIfmAPvx8M/ioBZ/b3xHHUWs3y98uFv2tm4dADSaCphfSVL6fJxeMUOLf47eM7
         2fr6nLaTLzurVx5YTUExA/f+SXhWgw1PM3oatOJ1+7HBGs8Q8nlfbLlG00kIb468zhpK
         GnRF8cbecoOHHbciLZ00gFSvV8/AEUZ1+UwxkL3DYRNh8Yd/LQ9rmn1dpv65fGSbgthL
         XNMzWHGd99NWosCThvGxebbpwvmHXOOjkG5viHhZGd+oKpOL6VPfWX2ZepAOf07N2ilw
         VCqdcip6T4ZKzNTotgYShjKEonk78b1qUjUYHF8Nef3qUeauWYWfwZmDB8c5pSa4e8ll
         dgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687264570; x=1689856570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWBDXIcglRuVtZI8959sIG7iLkywrHbYxE58IPCNYGE=;
        b=ldx5Sl9x3wmwZkP9AKzQLjUZVcB/770/4xDzm/IUPvXbXgZMFbs6EfHuefL/OjKeoK
         07cLdXilaV0klSGmbguxMoy/p8W5k2BMi+DDo8hGtiwvNJ2RhJA6l8DdISLDaqaG8cCD
         aswx2MQiRCj4S67qAc/xRBZ9hrHfJIr7sitHomtqGFuvgHBGeEKhJSusddySR/UC1Zt3
         FnnNmkSsOfEsOaNulJPn4yuoxt45nPeG7Rh4EIm1IzkA8l6fLG8+PJOWdnpE+XfqHApb
         7qvDtPbZLWNgAH7ZOWuF2PuAeE8f9nSPRjUp+Ut2E9wQSbECb0T+0UJFHazcpQFCJzSV
         SyFA==
X-Gm-Message-State: AC+VfDxqZQ3ISMd61ef5Xpa0TugOpo9z21ln8U2qCX51vlChnYtA/Yc/
        1Lqli0DtO7M9ST91dvGv0/k=
X-Google-Smtp-Source: ACHHUZ6EkPfBK22/FWvZGrk/sHCnUiSwEHMUioxVXNIy3vpveH/LF7mWH0ezEfhW232alFwcXB7l0g==
X-Received: by 2002:ac2:5f8a:0:b0:4f8:a858:e616 with SMTP id r10-20020ac25f8a000000b004f8a858e616mr1669032lfe.5.1687264569611;
        Tue, 20 Jun 2023 05:36:09 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id x5-20020ac259c5000000b004f25df23cddsm348614lfn.170.2023.06.20.05.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:36:09 -0700 (PDT)
Date:   Tue, 20 Jun 2023 15:36:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <eqngnojn7osrrpqetqxqomce3wij3icxemb3og55oiwg4toiwj@hi3bfboknx4v>
References: <TYBPR01MB53417E55F5F9E667D679901CD850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230608121115.qnilmougdfd6fdyq@mobilestation>
 <TYBPR01MB5341AD39983D6B39034AF01BD851A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230609105407.c4olqepv7vuoqktz@mobilestation>
 <TYBPR01MB53411835ACCD884FCA9ECBE2D854A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230612195149.hdnttkcabynmf4kx@mobilestation>
 <TYBPR01MB534161A79DFF1830B65D303FD85AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230614113924.7ssdcl2njivdienp@mobilestation>
 <20230614193131.6nlqyzwmhpv23ksv@mobilestation>
 <TYBPR01MB53418EF6548818FCA2D1F45DD85CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53418EF6548818FCA2D1F45DD85CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 12:02:08PM +0000, Yoshihiro Shimoda wrote:
> Hello Serge,
> 
> > From: Serge Semin, Sent: Thursday, June 15, 2023 4:32 AM
> > 
> > On Wed, Jun 14, 2023 at 02:39:29PM +0300, Serge Semin wrote:
> > > On Wed, Jun 14, 2023 at 02:30:13AM +0000, Yoshihiro Shimoda wrote:
> > > > Hello Serge,
> > > >
> > > >  From: Serge Semin, Sent: Tuesday, June 13, 2023 4:52 AM
> > > > >
> > > > > On Mon, Jun 12, 2023 at 01:19:02PM +0000, Yoshihiro Shimoda wrote:
> > > > > > Hello Serge,
> > > > > >
> > > > > > > From: Serge Semin, Sent: Friday, June 9, 2023 7:54 PM
> > > > > > <snip>
> > > > > > > > > > static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > > > > > > > {
> > > > > > > > > >         struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > > > > > > > >         int i;
> > > > > > > > > >
> > > > > > > > > >         rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > > > > > >
> > > > > > > > > >         /*
> > > > > > > > > >          * Require direct speed change here. Otherwise RDLH_LINK_UP of
> > > > > > > > > >          * PCIEINTSTS0 which is this controller specific register may not
> > > > > > > > > >          * be set.
> > > > > > > > > >          */
> > > > > > > > >
> > > > > > > > > >         if (rcar->needs_speed_change) {
> > > > > > > > >
> > > > > > > > > Seeing this is specified for the root port only what about
> > > > > > > > > replacing the statement with just test whether the rcar_gen4_pcie.mode ==
> > > > > > > > > DW_PCIE_RC_TYPE? Thus you'll be ablt to drop the needs_speed_change field.
> > > > > > > >
> > > > > > > > Thank you for the comment. I'll fix it.
> > > > > > > >
> > > > > > > > > BTW Just curious. Why is the loop below enabled for the Root Port
> > > > > > > > > only? What about the end-point controller? It's the same hardware
> > > > > > > > > after all..
> > > > > > > >
> > > > > > > > This is reused from v16 and then it used "link retraining" which is only for
> > > > > > > > the Root Port. As you mentioned, it seems endpoint controller is also needed
> > > > > > > > if we use direct speed change.
> > > > > > > >
> > > > > > > > > >                 for (i = 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > > > > > > > >                         rcar_gen4_pcie_speed_change(dw);
> > > > > > > > > >                         msleep(100);
> > > > > > > > > >                         if (rcar_gen4_pcie_check_current_link(dw))
> > > > > > > > > >                                 return 0;
> > > > > > > > > >                 }
> > > > > > > > >
> > > > > > > > > Did you trace how many iterations this loop normally takes?
> > > > > > > >
> > > > > > > > i = 0 or 1 (if the max-link-speed is suitable for a connected device.)
> > > > > > > >
> > > > > > > > > Is it
> > > > > > > > > constant or varies for the same platform setup and a connected link
> > > > > > > > > partner? Does the number of iterations depend on the target link speed
> > > > > > > > > specified via the "max-link-speed" property?
> > > > > > > >
> > > > > > >
> > > > > > > > This is not related to the "max-link-speed". It seems to related to
> > > > > > > > a link partner.
> > > > > > > > 		LinkCap	max-link-speed	loop
> > > > > > > > Device A		4	4		1
> > > > > > > > Device A		4	3		1
> > > > > > > > Device B		3	3		0
> > > > > > >
> > > > > > > Great! If so I would have just left a single unconditional
> > > > > > > rcar_gen4_pcie_speed_change() call placed right after the
> > > > > > > rcar_gen4_pcie_ltssm_enable() method with no delays afterwards. These
> > > > > > > methods would have been invoked in the framework of
> > > > > > > dw_pcie_start_link() after which the dw_pcie_wait_for_link() method is
> > > > > > > called with several checks parted with the ~100ms delay. It will make
> > > > > > > sure that at least some link is up with the link state printed to the
> > > > > > > system log. If for some reason the performance degradation happens
> > > > > > > then it will be up to the system administrator to investigate what was
> > > > > > > wrong. Your driver did as much is it could to reach the best link gen.
> > > > > >
> > > > > > IIUC, is your suggestion like the following code?
> > > > > > ---
> > > > > > 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > > 	if (!dw_pcie_wait_for_link(dw)) {
> > > > > > 		rcar_gen4_pcie_speed_change(dw);
> > > > > > 		return 0;
> > > > > > 	}
> > > > > > ---
> > > > > >
> > > > > > Unfortunately, it doesn't work correctly...
> > > > > > The following code can work correctly. The value of i is still 1 on the device A.
> > > > > > What do you think that the following code is acceptable?
> > > > > > ---
> > > > > > 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > > 	for (i = 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > > > > 		msleep(100);
> > > > > > 		rcar_gen4_pcie_speed_change(dw);
> > > > > > 		if (dw_pcie_link_up(dw)) {
> > > > > > 			printk("%s:%d\n", __func__, i);
> > > > > > 			return 0;
> > > > > > 		}
> > > > > > 	}
> > > > > > ---
> > > > >
> > > > > My idea was to implement something like this:
> > > > >
> > > > > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > > +{
> > > > > +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > > > +
> > > > > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > +
> > > > > +	rcar_gen4_pcie_speed_change(dw);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > >
> > > > > and retain the rcar_gen4_pcie_link_up() method as is.
> > > >
> > > > Unfortunately, such a code doesn't work on my environment...
> > > >
> > > > > * Note: originally your loop used to have the msleep() call performed
> > > > > after the first rcar_gen4_pcie_speed_change() invocation. Thus the
> > > > > delay can be dropped if there is only one iteration implemented (see
> > > > > further to understand why).
> > > >
> > > > Calling rcar_gen4_pcie_speed_change() multiple times is required on
> > > > my environment. I thought msleep(100) was quite long so that I tried
> > > > other wait interval like below:
> > > >
> > > >  msleep(1) : about 5 loops is needed for link. (about 5 msec.)
> > > >  usleep_range(100, 110) : about 400 loops is needed for link. (about 40 msec.)
> > > >  usleep_range(500, 600) : about 80 loops is needed for link. (about 40 msec.)
> > > >
> > > > The delay timing doesn't seems important. Both cases below can work correctly.
> > > > --- case 1 ---
> > > > 	for (i = 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > > 		rcar_gen4_pcie_speed_change(dw);
> > > > 		if (dw_pcie_link_up(dw)) {
> > > > 			printk("%s:%d\n", __func__, i); // will be removed
> > > > 			return 0;
> > > > 		}
> > >
> > > > 		msleep(1);
> > >
> > > Why? Just set it to 5 ms. In anyway please see the next message.
> > >
> > > > 	}
> > > > ---
> > > > --- case 2 ---
> > > > 	for (i = 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > > 		rcar_gen4_pcie_speed_change(dw);
> > > > 		msleep(1);
> > > > 		if (dw_pcie_link_up(dw)) {
> > > > 			printk("%s:%d\n", __func__, i); // will be removed
> > > > 			return 0;
> > > > 		}
> > > > 	}
> > > > ---
> > > >
> > > > So, I'll use case 1 for it.
> > >
> > > Ah. I think I get it now. Your spreadsheet:
> > >
> > >                 LinkCap max-link-speed  loop
> > > Device A           4          4           1
> > > Device A           4          3           1
> > > Device B           3          3           0
> > >
> > > actually meant (loop+1) iterations. So in case of Gen4 you'll need
> > > three speed changes (one already enabled in the dw_pcie_setup_rc()
> > > method and another two ones are performed in your loop). Similarly in
> > > case of Gen3 you'll need only one iteration. I bet you won't need to
> > > call rcar_gen4_pcie_speed_change() at all if gen2 needs to be trained.
> > > Could you try it out?
> > >
> > > Anyway based on what you discovered and on my experience working with
> > > that controller, there should be as many
> > > GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag changes as the target speed
> > > value, i.e. no flag switch if Gen1 is required, one flag switch if
> > > Gen2 is required and so on. Although I failed to find any explicit
> > > statement about that in the HW-manual.
> > >
> > > In addition to the above I've found out that
> > > GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE field is actually self cleared when
> > > the speed change occurs (see the register description in the HW
> > > reference manual). We can use it to implement the
> > > dw_pcie_link_up()-independent link training algorithm like this:
> > >
> > > +#define RCAR_RETRAIN_MAX_CHECK		10
> > > +#define RCAR_LINK_SPEED_MAX		4
> > > +
> > > +static bool rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
> > > +{
> > > +	u32 val;
> > > +	int i;
> > > +
> > > +	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > > +	val &= ~PORT_LOGIC_SPEED_CHANGE;
> > > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > +
> > > +	val |= PORT_LOGIC_SPEED_CHANGE;
> > > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > +
> > > +	for (i = 0; i < RCAR_SPEED_CHANGE_WAIT_RETRIES; i++) {
> > > +		val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > > +		if (!(val & PORT_LOGIC_SPEED_CHANGE))
> > > +			return true;
> > > +
> > > +		msleep(1);
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > +{
> > > +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > +	int i, changes;
> > > +
> > > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > +
> > 
> > > +	changes = min_not_zero(dw->link_gen, RCAR_LINK_SPEED_MAX);
> > 
> > This should have been:
> > +changes = min_not_zero(dw->link_gen, RCAR_LINK_SPEED_MAX) - 1;
> > because Gen1 doesn't need any speed change action.
> > 
> > But this part can be further improved. Instead of the code above the
> > next snipped can be implemented:
> > 
> > +changes = min_not_zero(dw->link_gen, RCAR_LINK_SPEED_MAX) - 1;
> > +if (changes && rcar->mode == DW_PCIE_RC_TYPE)
> > +		changes -= 1;
> > 
> > It takes into account that the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE
> > flag is already set in the dw_pcie_setup_rc() method. So Gen2 will be
> > trained with no need in addition actions. If it's supported of course.
> 

> Thank you very much for your comments and suggestion! The suggestion code
> works correctly on my environment.

Awesome! Glad we've finally settled this.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> P.S.
> So, I'm investigating endpoint mode issues which you commented now.
> 
> > -Serge(y)
> > 
> > > +	for (i = 0; i < changes; ++i) {
> > > +		if (!rcar_gen4_pcie_speed_change(dw))
> > > +			break;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > >
> > > Note 1. The actual link state will be checked in the framework of the
> > > dw_pcie_wait_for_link() function, by means of dw_pcie_link_up().
> > >
> > > Note 2. RCAR_LINK_SPEED_MAX is deliberately set to 4 because DW PCIe
> > > EP core driver doesn't set the PORT_LOGIC_SPEED_CHANGE flag. In case
> > > of the DW PCIe Root Port at most 3 iterations should be enough.
> > >
> > > Note 3. Please use the RCAR_ prefix for the vendor-specific macros.
> > > It concerns the entire series.
> > >
> > > Could you try out the code suggested above?
> > >
> > > -Serge(y)
> > >
> > > >
> > > > > You don't need to wait for the link to actually get up in the
> > > > > start_link() callback because there is the link_up() callback, which
> > > > > is called from the dw_pcie_wait_for_link() method during the generic
> > > > > DWC PCIe setup procedure. See:
> > > >
> > > > Since the procedure will call rcar_gen4_pcie_speed_change() from
> > > > ->start_link() once, my environment cannot work correctly...
> > > >
> > > > Best regards,
> > > > Yoshihiro Shimoda
> > > >
> > > > > dw_pcie_host_init():
> > > > > +-> ops->host_init()
> > > > > +-> ...
> > > > > +-> dw_pcie_setup_rc()
> > > > > |   +-> ...
> > > > > |   +-> dw_pcie_setup()
> > > > > |   +-> ...
> > > > > +-> if !dw_pcie_link_up()
> > > > > |   |   +-> ops->link_up()
> > > > > |   +-> dw_pcie_start_link()
> > > > > |       +-> ops->start_link()
> > > > > +-> dw_pcie_wait_for_link();   // See, wait-procedure is already performed
> > > > > |   +-> loop 10 times          // for you in the core driver together
> > > > > |       +-> dw_pcie_link_up()  // with the delays between the checks
> > > > > |           +-> ops->link_up()
> > > > > |       +-> msleep(~100)
> > > > > +-> ...
> > > > >
> > > > > -Serge(y)
> > > > >
> > > > > >
> > > > > > Best regards,
> > > > > > Yoshihiro Shimoda
> > > > > >
> > > > > > > -Serge(y)
> > > > > >
