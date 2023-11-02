Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE37DEB44
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 04:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348277AbjKBDSj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 23:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBDSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 23:18:39 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE411D;
        Wed,  1 Nov 2023 20:18:32 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5b9377e71acso365312a12.0;
        Wed, 01 Nov 2023 20:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698895111; x=1699499911;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgjUtC+zu8DJl3nutAj39PQhgJ4yZrn+eZKN8r9ua1A=;
        b=MDrEhN5w37xqz8vOSUwLeOdmDFXHkF2kdBDeD4ePD0gJjd9x8M58D47HaAd9WGlhpV
         /8OhSf03xIcZbqVOBNxs0B97+Ltx3a9mdnGk7tIzX8TneBc6alr/DmZEqaaXWpySnSoZ
         KrFiiLFyHxjg9TDjlRPYXbH2xTq0SpcPZc8o7cyR9S7e47V5mzUSrtCjEeC5D7NoRiA7
         aw4CV2pVdCp+jX5BGkQWomNJXQYFxXE5dr+pd5vyI45+JlCY6sbaJFJS1jd9uoFdpMZI
         OZIgEx2b3JCswrfxklxvhcUhVoY350gnOdFkW1CwLuTly85VBHC7HZJUKyVBmywlK6TL
         X9tQ==
X-Gm-Message-State: AOJu0Yx1658X51kZaPFoEBJiReL/3fYu/8cb//dp4dKCQgpKDA7QWqGv
        EVzmrdDwGxVyt/p7/yJsDq69dohMyoQ=
X-Google-Smtp-Source: AGHT+IGSCfdmNS3mXmmzwZOCcGimxAePh6gkFXbuO2VON++1MpnZsCB/34fPgfD7x43Ga95vlV7Ung==
X-Received: by 2002:a05:6a20:8f07:b0:181:6f00:2f73 with SMTP id b7-20020a056a208f0700b001816f002f73mr3080416pzk.3.1698895111246;
        Wed, 01 Nov 2023 20:18:31 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090ac90300b002800b26dbc1sm1442581pjt.32.2023.11.01.20.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 20:18:30 -0700 (PDT)
Date:   Thu, 2 Nov 2023 12:18:28 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux.dev>,
        Linux KVM <kvm@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2023 - See you soon!
Message-ID: <20231102031828.GA951173@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone!

Time truly flies!  The Linux Plumbers Conference starts in less than two
weeks. Hopefully, everyone is excited and has booked their attendance,
hotel rooms, flights, etc. :)

The conference agenda is now available at https://lpc.events/event/17/program,
and the complete schedule is at https://lpc.events/event/17/timetable.  All the
talks this year look amazing!

The VFIO/IOMMU/PCI micro-conference schedule has also been finalised and
can seen at https://lpc.events/event/17/sessions/172/#20231115.  We have
some fantastic speakers this year!

As before, please keep an eye on the  official conference website for
updates:

  https://lpc.events

Previous posts about the MC:

  - https://lore.kernel.org/linux-pci/20230821170936.GA749626@rocinante/
  - https://lore.kernel.org/linux-pci/20230711200916.GA699236@rocinante/
  - https://lore.kernel.org/linux-pci/20230620114325.GA1387614@rocinante/
  - https://lore.kernel.org/all/20230828140306.GA1457444@rocinante/

See you at the LPC 2023!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof
