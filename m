Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281F144DFF6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 02:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhKLBw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 20:52:27 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:46752 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKLBw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 20:52:26 -0500
Received: by mail-ed1-f49.google.com with SMTP id c8so31005860ede.13;
        Thu, 11 Nov 2021 17:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fyns7PGwi1nfJqRDZjvXK/mvlnBAuT8br2C5PXbXMRY=;
        b=bxLlYi7N+iw4sgUwzDRfRAcx/a0d21zg776cQPLhJIDujs2FxZA57IszfKrXL2Gf+L
         YrYW7lObmLRK4BGepQM/diFC7He4ifc22ytswLwGXc1dvOhqYfBP3XzLUM6wlyje5l9W
         pzy1gLeZf2x3m3UY9JK+p29xotZD1Fmdv26Anw1wd4/2Wjjn0l3n/djmkuGXrxyq7w3x
         1duw55afkLtLEs9SS75Wq1bImPPafJputQqwuVe2cO2FmlTTgfQaLGl7tBd2lTT7OOXw
         WHZmiuuTrCToLHoVG63EXyyWOJTzY4GoiTulopa84EoWvmbvWxerP5CVD1k/rUwp3wHQ
         UlLg==
X-Gm-Message-State: AOAM530sCgiBToZ+NPlpRciORHIhGNRZBSPbEL7P35/lfi0cvVSMmOFH
        RqOMfVMAzHxsCsqzNzqvS3oyqdZAqSGZ0uCA
X-Google-Smtp-Source: ABdhPJzaVm4/QpsKbW7VsF6RHavf6FhHi7q4YaFu4dR9lvyYd3nzjCUEIvwjy9pCQuBcRItqb7vIig==
X-Received: by 2002:a17:906:300b:: with SMTP id 11mr12453058ejz.57.1636681776068;
        Thu, 11 Nov 2021 17:49:36 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id gs15sm2130440ejc.42.2021.11.11.17.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 17:49:35 -0800 (PST)
Date:   Fri, 12 Nov 2021 02:49:34 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "Bao, Joseph" <joseph.bao@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Message-ID: <YY3ILu0FUKnWwSm9@rocinante>
References: <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211109152951.GA1146992@bhelgaas>
 <DM8PR11MB57020F3491E508A334469E2186949@DM8PR11MB5702.namprd11.prod.outlook.com>
 <YY247SPgRT8OpNrF@rocinante>
 <DM8PR11MB5702198ABAD1DF43237CC1D586959@DM8PR11MB5702.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5702198ABAD1DF43237CC1D586959@DM8PR11MB5702.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joseph,

> Yeah, other people may encounter a similar issue, I've created
> https://bugzilla.kernel.org/show_bug.cgi?id=214989 for reference
> including the patch from Stuart.

Thank you so much!  I appreciate that.

To add, the Bugzilla link above would need to be included in the commit
message for the final patch as per the usual.

	Krzysztof
