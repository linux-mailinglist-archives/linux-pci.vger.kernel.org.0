Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2345780F5D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378233AbjHRPie convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378349AbjHRPi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 11:38:28 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8C2D59;
        Fri, 18 Aug 2023 08:38:27 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56cae50792fso149034eaf.1;
        Fri, 18 Aug 2023 08:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692373106; x=1692977906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrcBbOgB9abSh1ii/A4pjN8XYyD6eq5WmPdscOOUdAo=;
        b=FvnR+nlHiSttYI7mAh9IibXiJTZK6c3dg2Um13ySeKHBX1w8sGu9n2fpHr60fr+jxF
         CuOfk4VmzsHPYyJNemKfTUAJalN4Sh81w4Z3JIKZ1h+1bv9hyD0lTRj+Ka1W02wHrOKe
         HoeAvO1ML2fBScLLL9rpdAden1N+JIu4DP+IaWA4NbYgTZr8mJSLtpT83WURe7/tUMcG
         yx+RD93gJ9mzWtTFIu8WZ16J3vzBvSqYUX2Hv0g/ELgF1FX7OFSclWxclGthJVevb12B
         Zv64Ce5ETM+pH7oW8SqUN7dyGIEOdijtGEv3NcXaa81aw1l4Its0bK4tSeZWSSE8xiW/
         xbOw==
X-Gm-Message-State: AOJu0YwKdfQhk2lvzz0rr4EmRe+lSSltbzytGuqW0TW9+ppjhjxrXtso
        StxNssBk42FVARPa3ITwnPtg8EF2Ant53t/J5LnX6c2uf80=
X-Google-Smtp-Source: AGHT+IFmezXB5hKH/274aGodpVaSgvW9JFwXlfz/eE6Dgl0/+5FSQDa9ztog2CCYx3jaMpJv5bEHqDq2zwGKdZg3Bqs=
X-Received: by 2002:a05:6820:3d1:b0:56e:94ed:c098 with SMTP id
 s17-20020a05682003d100b0056e94edc098mr1715548ooj.0.1692373106302; Fri, 18 Aug
 2023 08:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-10-mario.limonciello@amd.com> <CAJZ5v0heB1yGcEzJCA88tyEhFi_LDWcHAF6xsrEFgH4j-DmT7Q@mail.gmail.com>
 <ZN9MQMjcNZK+Ul9z@smile.fi.intel.com> <0ed1f73e-3931-4e22-ac7a-22ce57094d67@amd.com>
In-Reply-To: <0ed1f73e-3931-4e22-ac7a-22ce57094d67@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 17:38:15 +0200
Message-ID: <CAJZ5v0jdqHeEFNbxTvVPHnC6uUVYmXKNVGZNMnSDVQDCyhCvNg@mail.gmail.com>
Subject: Re: [PATCH v13 09/12] ACPI: x86: s2idle: Add a function to get
 constraints for a device
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 4:04 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 8/18/2023 05:47, Andy Shevchenko wrote:
> > On Fri, Aug 18, 2023 at 10:31:03AM +0200, Rafael J. Wysocki wrote:
> >> On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >
> > ...
> >
> >>> +int acpi_get_lps0_constraint(struct device *dev)
> >>
> >> I think that some overhead would be reduced below if this were taking
> >> a struct acpi_device pointer as the argument.
> >
> > Hmm... Either you need a pointer to handle, which involves pointer arithmetics
> > or something else. I would believe if you tell that ACPI handle should be passed,
> > but current suggestion is not obvious to me how it may help.
>
> To Rafael's point about overhead there are potentially "less" calls into
> acpi_get_lps0_constraint if it's a 'struct acpi_device' pointer because
> it won't be called by caller for any devices that don't have an ACPI
> companion.
>
> >
> >>> +{
> >>> +       struct lpi_constraints *entry;
> >>> +
> >>> +       for_each_lpi_constraint(entry) {
> >>> +               if (!device_match_acpi_handle(dev, entry->handle))
> >
> > Here we retrieve handle...

Which uses ACPI_HANDLE() to retrieve the companion ACPI handle for
dev. This checks dev against NULL and then passes it to
ACPI_COMPANION() which resolves to to_acpi_device_node() on the dev's
fwnode field and that involves an is_acpi_device_node() check and some
pointer arithmetic via container_of().  Of course, this needs to be
done in every iteration of the loop until a matching handle is found
(or not), and because dev is always the same, the result of this will
be the same every time. If this is not pointless overhead then I'm not
quite sure how to call it.

Now, if struct acpi_device *adev is passed as the argument, the check
above reduces to (adev->handle == entry->handle) which is much more
straightforward IMV.

> >
> >>> +                       continue;
> >>> +               acpi_handle_debug(entry->handle,
> >>> +                                 "ACPI device constraint: %d\n", entry->min_dstate);
> >>> +               return entry->min_dstate;
> >>> +       }
> >
> >>> +       dev_dbg(dev, "No ACPI device constraint specified\n");
> >
> > ...and here we are using dev directly (otherwise acpi_handle_dbg() should be used).
>
> I'll just move the debugging statements into the caller of
> acpi_get_lps0_constraint().

Yeah, that works too.
