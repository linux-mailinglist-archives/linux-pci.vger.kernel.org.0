Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF879F085
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 19:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjIMRmV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Sep 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIMRmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 13:42:21 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BCD1986;
        Wed, 13 Sep 2023 10:42:16 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6b9cd6876bbso3726a34.1;
        Wed, 13 Sep 2023 10:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626936; x=1695231736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eglByz1BRArlf6Op7aiS6b20Xu4w3YO3B+8nUnzdnhI=;
        b=dFG+Rc5aO2HGG53viYGPhh1vq73QGfhooS2UYfpopepuganlmUaKXQlHRug+JziaG0
         ++iDRnu9WJn8y9oDfeFjBOEoSm0amPZowg5XE2rlgRY0a1II6Esx1VZjrGcOLR2oQW2D
         Tqn1aH17W2T3K/MzfWhWkc085vV0qXI0Pl0ODCdXjhzdmJ9FOhZzRQzSC9P/VNG8pIRe
         Fr8b8eS5BI4bupIbb7bzK0JaktyMtEGpeIF7qlGsrQ+B47Ea3QTVuvh9paT6k/cAhWwy
         3JX3eN4jqsKacb0A/M6ZpPHfhoySq/Fx+f1onasXhSdMjWHGHX3IVc0uVb4dKSmNIeuT
         yNvg==
X-Gm-Message-State: AOJu0YyGEr5mBu1nF413nenLaBMkVSt6CXuAwqugo9aUN63AV91GYlhq
        tJB2w29uMgGjOXAHAjIuMh/AfE3MTuggzjYASi7FIyi3
X-Google-Smtp-Source: AGHT+IGYGqRV1580/wSaJf1sNtkXqBowLvnO2+FeCJVMyhKA6jE/7lKya7uKnQ9tI3efx2Kjqgpmdx2gS8cnEAvBch8=
X-Received: by 2002:a05:6870:14d6:b0:1bb:724f:2bca with SMTP id
 l22-20020a05687014d600b001bb724f2bcamr3705529oab.1.1694626936155; Wed, 13 Sep
 2023 10:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230913154036.GA433234@bhelgaas> <8cd30700-d084-4a55-ab46-6e8db6706aa4@amd.com>
In-Reply-To: <8cd30700-d084-4a55-ab46-6e8db6706aa4@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Sep 2023 19:42:05 +0200
Message-ID: <CAJZ5v0hzdNYOLeOoM-4PZMQtr5J93kGA6Gidn_DVbFweMLb8vw@mail.gmail.com>
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 6:35 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/13/2023 10:40, Bjorn Helgaas wrote:
> > On Wed, Sep 13, 2023 at 12:20:14PM +0200, Rafael J. Wysocki wrote:
> >> On Wed, Sep 13, 2023 at 6:11 AM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:

[cut]

> >
> > Also, do we have some indication that this is specific to Ryzen?  If
> > not, I assume this is an ongoing issue, and matching on Device IDs
> > just means we'll have to debug the same problem again and add more
> > IDs.
>
> This is why my earlier attempts (v16 and v17) tried to tie it to
> constraints.  These are what the uPEP driver in Windows uses to make the
> decision of what power state to put integrated devices like the root
> port into.
>
> In Windows if no uPEP driver is installed "Windows internal policy"
> dictates what happens.  If the uPEP driver is installed then it
> influences the policy based upon the constraints.
>
> Rafael had feedback against constraints in v17, which is why I'm back to
> a quirk for v18.
>
> This issue as I've described it is specific to AMD Ryzen.

OK, so a quirk is the way to go IMO, because starting to rely on LPI
constraints in general retroactively is almost guaranteed to regress
things this way or another.

Whatever is done, it needs to be Ryzen-specific, unless there is
evidence that other (and in particular non-AMD) platforms are
affected.

> I expect it to be an ongoing issue.  I also expect unless we use
> constraints or convince the firmware team to add a _S0W object with a
> value of "0" for the sake of Linux that we will be adding IDs every year
> to wherever this lands as we reproduce it on newer SoCs.

So maybe the way to go is to make the AMD PMC driver set a flag for
Root Ports on suspend or similar.

In any case, I think that it would be good to agree on the approach at
the general level before posting any new patches, because we seem to
be going back and forth here.
