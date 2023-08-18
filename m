Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3A780F8F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378310AbjHRPsP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378311AbjHRPrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 11:47:53 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A9DD1;
        Fri, 18 Aug 2023 08:47:52 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d67c5e87cso183632eaf.0;
        Fri, 18 Aug 2023 08:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692373672; x=1692978472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsedMiohvIXVJRVYsj8/qaLjYWaDGUe70KiJ0FudpQI=;
        b=XExif7H1lrTXwWMJ53aloZ7kTLb2uzBvoNf7Ka8LCMgdA28d7Qhv6ZrtsfFNlY96Ze
         w6su1o+HFP1W6SOns3RbeTg7OANcDzmMaeLmU0SpOm9Se2NnGSn14UpPulOYK3ZQ/F7w
         S1MQvjIEylJEmP/bMVAmb8Fx7eBtvjrRbv2jYLwcWkKvt6CpYsfuEuOUTYzilyh4wpHs
         ZnyevsleTVBKfn7d0Hh99IZnzB++x1u6JwABp3T1VX+PNmGZeh6Cagtqc2ppJBT837I5
         SeKpX2kWqMbathHeqisNcMvZvK2QMEIZF5SkXdkmu9LleHgANsEqrYSLcmlekwAZLGTh
         FXQA==
X-Gm-Message-State: AOJu0YwRgcxGzi41cmW84jwtWb7mnK775xgOCiN8Oo/3LNVes3whQlhX
        Uy7EbETzsNVdg3CMAomQf4UWCBG2D8ySpEuC+KM=
X-Google-Smtp-Source: AGHT+IF9is1SR8iGVUtoWkvdA4nPO8F511+o72EOH72MKPxlpwtC4Eeee1nj2mfzAvTl/CMpqZx2pXm39rcfJiXi+4s=
X-Received: by 2002:a05:6820:44a:b0:563:3b56:5dc1 with SMTP id
 p10-20020a056820044a00b005633b565dc1mr3127017oou.0.1692373672110; Fri, 18 Aug
 2023 08:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-10-mario.limonciello@amd.com> <CAJZ5v0heB1yGcEzJCA88tyEhFi_LDWcHAF6xsrEFgH4j-DmT7Q@mail.gmail.com>
 <ZN9MQMjcNZK+Ul9z@smile.fi.intel.com> <0ed1f73e-3931-4e22-ac7a-22ce57094d67@amd.com>
 <CAJZ5v0jdqHeEFNbxTvVPHnC6uUVYmXKNVGZNMnSDVQDCyhCvNg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jdqHeEFNbxTvVPHnC6uUVYmXKNVGZNMnSDVQDCyhCvNg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 17:47:40 +0200
Message-ID: <CAJZ5v0jCB79Vh7KgWL=jDCETod43DfomXR4bUzjX=UMGzH2-iQ@mail.gmail.com>
Subject: Re: [PATCH v13 09/12] ACPI: x86: s2idle: Add a function to get
 constraints for a device
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Fri, Aug 18, 2023 at 5:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Aug 18, 2023 at 4:04 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > On 8/18/2023 05:47, Andy Shevchenko wrote:
> > > On Fri, Aug 18, 2023 at 10:31:03AM +0200, Rafael J. Wysocki wrote:
> > >> On Fri, Aug 18, 2023 at 7:15 AM Mario Limonciello
> > >> <mario.limonciello@amd.com> wrote:
> > >
> > > ...
> > >
> > >>> +int acpi_get_lps0_constraint(struct device *dev)
> > >>
> > >> I think that some overhead would be reduced below if this were taking
> > >> a struct acpi_device pointer as the argument.

Besides, I don't think that the constraints should be checked directly
from pci_bridge_d3_possible().

I'd rather check them from acpi_pci_bridge_d3() which knows the ACPI
companion of the given device already and can use it directly.
