Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811FA73797C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 05:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFUDIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 23:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUDIf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 23:08:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B310C1
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 20:08:33 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A20D43F72E
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2023 03:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687316911;
        bh=UBPZtGvQo+V6SDyZVSWIAeDYphAGCAkQ+a9RWWShpuM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Aj0lPeOB6UgFL7Ic5InrhTJNJ8M5VtzSMkYyNxSHt22aZ3she7RQe7yZu6bu7JjK6
         udgqoeFHo0bZQV4CeglJdB1qr6JCFmmmFq+SZapnPg3HzJL7S5AZeBJetyX1vby6aS
         9qPn869h9Rl3gkUkI8hyPVFupz9Pthkg8uNXaimhjt/2GVxZ3FVE4OzfsGt4wiQHxh
         DcdsOlhAQ6MJQ+dtWdiwthdNlVaptSzA+1C8eV+NG0602zehikvZqHRAhCVyP73lwE
         NEBXW+I8rlOXvMlvUJgfAPj/2syr//6wZVizERPgsChwBGvie3NgzhpSptV/ackskf
         XrSZONsSou0dw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-25e948f434cso4145944a91.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 20:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687316910; x=1689908910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBPZtGvQo+V6SDyZVSWIAeDYphAGCAkQ+a9RWWShpuM=;
        b=lX1GcSJySvTAfiNLE703edLiOCW4lrkZDtzYiq9+95LqfC4D9FDQ7RxLl5kx+haKao
         aNSDgVLE5E92zR3GNZZ+B8oHCjcpCyRrRjkmQqAkenQuWbDli0ThQ50R934Pg6JNQ23d
         zhYL6UWzYRmtwmEd1psNHmwn7WMwcIg1dU95eYYI+QdqsI1at07rV+GGvBi+h66wGkjZ
         VEsjSctfj5cXcBFKIy5aiZFMgefxPxsh3KXo/g5tMsYBDdMYR6Up2g/5CsdBA/1TtByb
         /6ksgn2mB2wC4dA7cqFDmhcYywYvdR863L2kS32a7CQFgZdITu5Pg/GBHiZhWXwN9MEA
         XUYw==
X-Gm-Message-State: AC+VfDzVN9KKAVWZhpde9jfqDbhqJIV168k92heYjGf10UelL0ZyqPWs
        AGfrnKngMbQC6aO9p189rYfd4jtZeaKBd9rGX/6ARzyUw5nbsEQYCPJRR2aNnZIeF0kddnRbyR8
        753Miv7w1GUZrA0YDCdH+zg/qPUHLD5x1XAZN8j8DJdZavPwX3cxmKg==
X-Received: by 2002:a17:90b:1d03:b0:25e:a057:afa with SMTP id on3-20020a17090b1d0300b0025ea0570afamr7466351pjb.13.1687316910301;
        Tue, 20 Jun 2023 20:08:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7JYEQszqNAybOs1jMnmKWXbXDeRjmdNw0iYFg+HVIACEZLPRwYJxTysM9wru1QObTrhsMmyojEJRIuewu0rVQ=
X-Received: by 2002:a17:90b:1d03:b0:25e:a057:afa with SMTP id
 on3-20020a17090b1d0300b0025ea0570afamr7466340pjb.13.1687316910045; Tue, 20
 Jun 2023 20:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230615070421.1704133-1-kai.heng.feng@canonical.com> <20230616220125.GA1555182@bhelgaas>
In-Reply-To: <20230616220125.GA1555182@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 21 Jun 2023 11:08:18 +0800
Message-ID: <CAAd53p5J8xTU6Fgo8m4h5wzy7w8x4jPugonrR9DTwk-QAm8fZQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 17, 2023 at 6:01=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
> > When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> > enabled for that device. However, when the device is plugged preboot,
> > ASPM is enabled by default.
> >
> > The disparity happens because BIOS doesn't have the ability to program
> > ASPM on hotplugged devices.
> >
> > So enable ASPM by default for external connected PCIe devices so ASPM
> > settings are consitent between preboot and hotplugged.
> >
> > On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
> > pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> > pcieport 0000:07:04.0: PCIe Bus Error: severity=3DCorrected, type=3DDat=
a Link Layer, (Receiver ID)
> > pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=3D0000008=
0/00002000
> > pcieport 0000:07:04.0:    [ 7] BadDLLP
> >
> > The root cause is still unclear, but quite likely because the I225 on
> > the dock supports PTM, where ASPM timing is precalculated for the PTM.
>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217557
>
> I know you said this isn't clear yet, but I don't see a connection
> between ASPM being enabled and PTM.  If anything, *disabling* ASPM
> should be safer if there's a timing issue.

If PTM timing is tested when ASPM is enabled, there can be a strong
connection between the two.

I'll raise the issue to IGC devs.

>
> I assume the ASPM timing you refer to is the LTR snoop/no snoop
> latency, since that's the only timing difference I see in the lspci
> output in bugzilla?

Not only LTR. ASPM L0s and L1 are not enabled when devices are hotplugged.

Kai-Heng

>
> I don't see any PTM differences there.
>
> Bjorn
