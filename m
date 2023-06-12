Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62772CFDE
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjFLTv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 15:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFLTv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 15:51:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10DE6B;
        Mon, 12 Jun 2023 12:51:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1b72dc2feso57170231fa.3;
        Mon, 12 Jun 2023 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686599513; x=1689191513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MWf7Q/K0NjrUwXki3MgZotu77l7jin1HkBnvAkN0hM=;
        b=cGe27AGOeRiiE3rHlHDW5TnBsYv23B5NqYJ3hIJ7b78fFZ+C2q16xDu8y5LKf5jto/
         ERsytukvKtPrzPcvmxdPufgvSH/N2dbzSI3N0EQEk0lTh2H0YqWrG3are75co3XxfG6U
         OHGCGriUMH2W2cEWLwzFXrNZsVZNkwGKuf5PLyuGB0yDy38k632lQFL6iVV9ozK6pgXz
         TfvrpgUfL2g7XHTz3ZifCNoSlJi4iXmZ9Cx2xupld7u5LU9emXVihC5GeHCPbRWkH4lw
         orPGcKhXrlG5qwQQpb2NzWJL9WPX3KW/Zk65mjo/U+1VGy4c2V8uhuDS/o148zUrtae2
         BUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686599513; x=1689191513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MWf7Q/K0NjrUwXki3MgZotu77l7jin1HkBnvAkN0hM=;
        b=WWZkOsZ/tfszCje1Yjp/CWSG+08SqZhHp/6LPq1jOTIcGFzKjynD0Y3aRq211nRoO2
         YW3C4ioX0AAuuu/WZDJl2hS8bjn6HLQGS7hd+3hUtFm10GkoHGk8+D4WuTEdUs69MwiE
         cHFLXMEzXU5J4ZTDumEJIydkdzdKwXVRsxKc2GOwHu4WUk3EKusZ82JEoScvl0RyeyES
         U6kJndPF7GjbFItwfX0yFHRehVx+jXC7eLOCGbU04PZxYpUV439Qz9hOsl1Hkv4iWzU0
         OzKlfe322FM8l2CVN6lW2i1VAi+feBmikslcNaxpmjPzQciLJ/rZOMWCu6Qi2lgJVhEk
         leAw==
X-Gm-Message-State: AC+VfDyUsBfw3qmWcK4j5/gWzAg8Sw/M4Oj47FMk90tRYbozqriaRzQ/
        ZK4vgxbJaUJ8o48osHUP++s=
X-Google-Smtp-Source: ACHHUZ4jlWoZM4ZZsiIEooIFTvhdYERK+lWUHl8q/EQDZd1d/3VJaUYAdgqlvIuInJZirF1rjD3Ejw==
X-Received: by 2002:a2e:8684:0:b0:2b1:ae68:82ca with SMTP id l4-20020a2e8684000000b002b1ae6882camr3885439lji.43.1686599512826;
        Mon, 12 Jun 2023 12:51:52 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id j9-20020a2e8249000000b002a7746800d0sm1900460ljh.130.2023.06.12.12.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:51:51 -0700 (PDT)
Date:   Mon, 12 Jun 2023 22:51:49 +0300
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
Message-ID: <20230612195149.hdnttkcabynmf4kx@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-20-yoshihiro.shimoda.uh@renesas.com>
 <20230605143908.fcgqzedp7oiarbyu@mobilestation>
 <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230607121533.cxvidvdqat5h2tqu@mobilestation>
 <TYBPR01MB53417E55F5F9E667D679901CD850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230608121115.qnilmougdfd6fdyq@mobilestation>
 <TYBPR01MB5341AD39983D6B39034AF01BD851A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230609105407.c4olqepv7vuoqktz@mobilestation>
 <TYBPR01MB53411835ACCD884FCA9ECBE2D854A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53411835ACCD884FCA9ECBE2D854A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 12, 2023 at 01:19:02PM +0000, Yoshihiro Shimoda wrote:
> Hello Serge,
> 
> > From: Serge Semin, Sent: Friday, June 9, 2023 7:54 PM
> <snip>
> > > > > static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > > {
> > > > >         struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > > >         int i;
> > > > >
> > > > >         rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > >
> > > > >         /*
> > > > >          * Require direct speed change here. Otherwise RDLH_LINK_UP of
> > > > >          * PCIEINTSTS0 which is this controller specific register may not
> > > > >          * be set.
> > > > >          */
> > > >
> > > > >         if (rcar->needs_speed_change) {
> > > >
> > > > Seeing this is specified for the root port only what about
> > > > replacing the statement with just test whether the rcar_gen4_pcie.mode ==
> > > > DW_PCIE_RC_TYPE? Thus you'll be ablt to drop the needs_speed_change field.
> > >
> > > Thank you for the comment. I'll fix it.
> > >
> > > > BTW Just curious. Why is the loop below enabled for the Root Port
> > > > only? What about the end-point controller? It's the same hardware
> > > > after all..
> > >
> > > This is reused from v16 and then it used "link retraining" which is only for
> > > the Root Port. As you mentioned, it seems endpoint controller is also needed
> > > if we use direct speed change.
> > >
> > > > >                 for (i = 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > > >                         rcar_gen4_pcie_speed_change(dw);
> > > > >                         msleep(100);
> > > > >                         if (rcar_gen4_pcie_check_current_link(dw))
> > > > >                                 return 0;
> > > > >                 }
> > > >
> > > > Did you trace how many iterations this loop normally takes?
> > >
> > > i = 0 or 1 (if the max-link-speed is suitable for a connected device.)
> > >
> > > > Is it
> > > > constant or varies for the same platform setup and a connected link
> > > > partner? Does the number of iterations depend on the target link speed
> > > > specified via the "max-link-speed" property?
> > >
> > 
> > > This is not related to the "max-link-speed". It seems to related to
> > > a link partner.
> > > 		LinkCap	max-link-speed	loop
> > > Device A		4	4		1
> > > Device A		4	3		1
> > > Device B		3	3		0
> > 
> > Great! If so I would have just left a single unconditional
> > rcar_gen4_pcie_speed_change() call placed right after the
> > rcar_gen4_pcie_ltssm_enable() method with no delays afterwards. These
> > methods would have been invoked in the framework of
> > dw_pcie_start_link() after which the dw_pcie_wait_for_link() method is
> > called with several checks parted with the ~100ms delay. It will make
> > sure that at least some link is up with the link state printed to the
> > system log. If for some reason the performance degradation happens
> > then it will be up to the system administrator to investigate what was
> > wrong. Your driver did as much is it could to reach the best link gen.
> 
> IIUC, is your suggestion like the following code?
> ---
> 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> 	if (!dw_pcie_wait_for_link(dw)) {
> 		rcar_gen4_pcie_speed_change(dw);
> 		return 0;
> 	}
> ---
> 
> Unfortunately, it doesn't work correctly...
> The following code can work correctly. The value of i is still 1 on the device A.
> What do you think that the following code is acceptable?
> ---
> 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> 	for (i = 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> 		msleep(100);
> 		rcar_gen4_pcie_speed_change(dw);
> 		if (dw_pcie_link_up(dw)) {
> 			printk("%s:%d\n", __func__, i);
> 			return 0;
> 		}
> 	}
> ---

My idea was to implement something like this:

+static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	rcar_gen4_pcie_ltssm_enable(rcar, true);
+
+	rcar_gen4_pcie_speed_change(dw);
+
+	return 0;
+}

and retain the rcar_gen4_pcie_link_up() method as is.

* Note: originally your loop used to have the msleep() call performed
after the first rcar_gen4_pcie_speed_change() invocation. Thus the
delay can be dropped if there is only one iteration implemented (see
further to understand why).

You don't need to wait for the link to actually get up in the
start_link() callback because there is the link_up() callback, which
is called from the dw_pcie_wait_for_link() method during the generic
DWC PCIe setup procedure. See:

dw_pcie_host_init():
+-> ops->host_init()
+-> ...
+-> dw_pcie_setup_rc()
|   +-> ...
|   +-> dw_pcie_setup()
|   +-> ...
+-> if !dw_pcie_link_up()
|   |   +-> ops->link_up()
|   +-> dw_pcie_start_link()
|       +-> ops->start_link()
+-> dw_pcie_wait_for_link();   // See, wait-procedure is already performed
|   +-> loop 10 times          // for you in the core driver together
|       +-> dw_pcie_link_up()  // with the delays between the checks
|           +-> ops->link_up()
|       +-> msleep(~100)
+-> ...

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> 
