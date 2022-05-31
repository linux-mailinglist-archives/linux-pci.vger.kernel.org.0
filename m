Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C7539768
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbiEaTzN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbiEaTzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 15:55:11 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB93C8FD50
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 12:55:10 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f2a4c51c45so19758813fac.9
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 12:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lU+XaCA3KFJpqMQ2bWbphFy50eKMvz22KVLB4HVoX2M=;
        b=ouDLb8Hf/oRKftm/aHYN/2ErMOXLklI+T40ynorJMd3ofZzTc4ipfbgtV7Jp6SJXaQ
         SQTo3guNzPmQbafwO5lgeakttjOhaM1lxQJorjFBX8OxCy1/BK15AkjlBCUttuGLcTqb
         Gf6B2sZfK+nR3Mq++YwyF+juxajvfIP8E2WFXY7ftdXFdjvY3oGOOgnZlf3mNQYB9Oe1
         HwccT5LEs+HxB8n6MNxznIrIXtN54qkOjL44eOI5C/wEGCAdulXCPECV2YD5LqaT0hrf
         cy5m66y3inIIexfhV8wZXczNpDBwgVNDA8BAD7wWciYOndVpUuzYoXpaTR3uGKmrneGt
         XVYg==
X-Gm-Message-State: AOAM532hdqBvgjef8W7NyMHIpvUKVNWc13uXc0CFpWi49+n9TA1sH5jZ
        zj670TCEZ/257K2UTMYREyasJLfbfw==
X-Google-Smtp-Source: ABdhPJyF6Nm50JrNkJEO9wa7JHVp62my3KDQqkFz37ua6MoQKaovwyy2d4ZQRsx2/lOwoBYFIajnPw==
X-Received: by 2002:a05:6870:f697:b0:f1:cbce:6bab with SMTP id el23-20020a056870f69700b000f1cbce6babmr13854969oab.75.1654026908828;
        Tue, 31 May 2022 12:55:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fw11-20020a056870080b00b000f2c0ec657asm6114532oab.0.2022.05.31.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 12:55:08 -0700 (PDT)
Received: (nullmailer pid 2178975 invoked by uid 1000);
        Tue, 31 May 2022 19:55:07 -0000
Date:   Tue, 31 May 2022 14:55:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: aardvark: Add support for AER registers on
 emulated bridge
Message-ID: <20220531195507.GC1808817-robh@kernel.org>
References: <20220524132827.8837-1-kabel@kernel.org>
 <20220524132827.8837-2-kabel@kernel.org>
 <20220526203801.GI54904-robh@kernel.org>
 <20220529120813.7dcb5aaf@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220529120813.7dcb5aaf@thinkpad>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 29, 2022 at 12:08:13PM +0200, Marek Behún wrote:
> On Thu, 26 May 2022 15:38:01 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Tue, May 24, 2022 at 03:28:26PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > Aardvark controller supports Advanced Error Reporting configuration
> > > registers.
> > > 
> > > Export these registers on the emulated root bridge via the new .read_ext
> > > and .write_ext methods.
> > > 
> > > Note that in the Advanced Error Reporting Capability header the offset
> > > to the next Extended Capability header is set, but it is not documented
> > > in Armada 3700 Functional Specification. Since this change adds support
> > > only for Advanced Error Reporting, explicitly clear PCI_EXT_CAP_NEXT
> > > bits in AER capability header.
> > > 
> > > Now the pcieport driver correctly detects AER support and allows PCIe
> > > AER driver to start receiving ERR interrupts. Kernel log now says:
> > > 
> > >     [    4.358401] pcieport 0000:00:00.0: AER: enabled with IRQ 52
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>  
> > 
> > Did you mean Reviewed-by? Signed-off-by is only correct if Lorenzo 
> > applied or rewrote these. If he applied them, then Bjorn will pick them 
> > up.
> 
> Hmm. Well, Lorenzo applied the subset I am sending (patches 3 and 5) to
> his tree, with SOB, meaning to send it to Bjorn [1].
> 
> Then we discovered that patch 4 is also required for the _SHIFT
> macros, which was discussed previously that we want to avoid those, and
> use FIELD_PREP() / FIELD_GET() instead [2].
> 
> So I updated the second patch to use FIELD_PREP() / FIELD_GET() instead
> of the _SHIFT macros. I guess this version isn't SOB by Lorenzo, but
> the first version was... I should probably change it to Reviewed-by for
> both patches anyway, right?

I would suggest you send these without either (unless Lorenzo actually 
gave a Reviewed-by) and just state that Lorenzo applied these, but then 
you had to make another change as you described above.

But if Bjorn applies the original and doesn't want to rebase (he 
usually will rebase if needed), then an incremental patch will be 
needed.

Rob
