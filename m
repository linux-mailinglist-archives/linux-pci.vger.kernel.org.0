Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B67E4950
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKGTjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 14:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjKGTjN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 14:39:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331D10C6
        for <linux-pci@vger.kernel.org>; Tue,  7 Nov 2023 11:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699385904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JFtzha1JbWEIPRDSewC1qHZEFrnoECJinIv2TMAU/Lc=;
        b=IjVjGaB2G9NgdE2ugDsKTFvj/06mkeuISC+UfbBAW5bvMlgHr9s4j4hnaaMFWCZ2U99buq
        XIYxMFrZmc12BnsrEa0P499zJZG3PgOiYNW3lvStLDmDTSUWkmSd6R5sUlOTwIUP4ybVZm
        mHWyl58qYKCTcZ0YzEY+5BxC/1q09hw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-rGno_ZgQNRmLmxDUVOmlKg-1; Tue, 07 Nov 2023 14:38:23 -0500
X-MC-Unique: rGno_ZgQNRmLmxDUVOmlKg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d3f71f49cso16646366d6.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Nov 2023 11:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385902; x=1699990702;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFtzha1JbWEIPRDSewC1qHZEFrnoECJinIv2TMAU/Lc=;
        b=GzsJzh6txOJ7t2pXqGywQclf6YE/VPLYP9dsZbbuP8LzTonYRiqMnBTxzCmgbn+szC
         Fuj7Ig2stWRiJ5rDt530+vGA9e0+7xH5PsioQEtXGuKCiilLeA+F7Xj1Jcx/lF0fSO0X
         2eOKJCdBt/2osEbbK/azIRCtHUM9kdoOB55gN+kTTIfbDJLOdm1M1lhquXZUE+8YYTug
         /u3KBdwVAJZ1BfY9AIElog6gZhjUxP8QLh5UxQC1QQTw3Is8wDdXTUnlbHPX9kZ2DUB/
         jlerj01XJE/yr97pt3iyPMoptJy9PHR4ufJKzjWr1xwFUjDjiBFJCovtxdpTe2BGAAt/
         JXSA==
X-Gm-Message-State: AOJu0Yz7NBGPeqnUR6SyY2LArOXKUnkLPpsg6Qh1FaY42OejY4hzLipn
        pRhYfj+YwB9rjyaoQBIcs9Gy2FSkqWhiZz9xFjhxX8GZ8f1bd4kAJTxW2GGaJKuc1rM5Gsig3FH
        G8r+QV/9hiGwUague9tmwZAxUpV0ed475KaS6jiIl42jOp5x+GmLs1VEdfkd4pTuHMmaTd8L9hM
        1twcUC
X-Received: by 2002:a05:6214:4993:b0:66d:1b4e:77d6 with SMTP id pf19-20020a056214499300b0066d1b4e77d6mr34189543qvb.5.1699385901961;
        Tue, 07 Nov 2023 11:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGdUFhqB95DEEaNf+A7ev9h/xHKbl8QUfCv3AgVm7mvm9jWaDnd40Jrnc7eXX4aZ+9aEIGSw==
X-Received: by 2002:a05:6214:4993:b0:66d:1b4e:77d6 with SMTP id pf19-20020a056214499300b0066d1b4e77d6mr34189517qvb.5.1699385901601;
        Tue, 07 Nov 2023 11:38:21 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c0:300:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id j19-20020ac86653000000b0041811e71890sm219156qtp.33.2023.11.07.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:38:21 -0800 (PST)
Message-ID: <84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com>
Subject: Implementation details of PCI Managed (devres) Functions
From:   Philipp Stanner <pstanner@redhat.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <htejun@gmail.com>, dakr@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Philipp Stanner <pstanner@redhat.com>, jeff@garzik.org,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 07 Nov 2023 20:38:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I'm currently working on porting more drivers in DRM to managed pci-
functions. During this process I discovered something that might be
called an inconsistency in the implementation.

First, there would be the pcim_ functions being scattered across
several files. Some are implemented in drivers/pci/pci.c, others in
lib/devres.c, where they are guarded by #ifdef CONFIG_PCI
=E2=80=93 this originates from an old cleanup, done in
5ea8176994003483a18c8fed580901e2125f8a83

Additionally, there is lib/pci_iomap.c, which contains the non-managed
pci_iomap() functions.

At first and second glance it's not obvious to me why these pci-
functions are scattered. Hints?


Second, it seems there are two competing philosophies behind managed
resource reservations. Some pci_ functions have pcim_ counterparts,
such as pci_iomap() <-> pcim_iomap(). So the API-user might expect that
relevant pci_ functions that do not have a managed counterpart do so
because no one bothered implementing them so far.

However, it turns out that for pci_request_region(), there is no
counterpart because a different mechanism / semantic was used to make
the function _sometimes_ managed:

=C2=A0=C2=A0 1. If you use pcim_enable_device(), the member is_managed in s=
truct
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev is set to 1.
=C2=A0=C2=A0 2. This value is then evaluated in pci_request_region()'s call=
 to
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find_pci_dr()

Effectively, this makes pci_request_region() sometimes managed.
Why has it been implemented that way and not as a separate function =E2=80=
=93
like, e.g., pcim_iomap()?

That's where an inconsistency lies. For things like iomappings there
are separate managed functions, for the region-request there's a
universal function doing managed or unmanaged, respectively.

Furthermore, look at pcim_iomap_regions() =E2=80=93 that function uses a mi=
x
between the obviously managed function pcim_iomap() and
pci_request_region(), which appears unmanaged judging by the name, but,
nevertheless, is (sometimes) managed below the surface.
Consequently, pcim_iomap_regions() could even be a little buggy: When
someone uses pci_enable_device() + pcim_iomap_regions(), wouldn't that
leak the resource regions?

The change to pci_request_region() hasn't grown historically but was
implemented that way in one run with the first set of managed functions
in commit 9ac7849e35f70. So this implies it has been implemented that
way on purpose.

What was that purpose?

Would be great if someone can give some hints :)

Regards,
P.

