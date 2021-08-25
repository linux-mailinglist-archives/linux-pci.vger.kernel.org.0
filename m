Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8343F7ED7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhHYXD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 19:03:29 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56019 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 19:03:29 -0400
Received: by mail-wm1-f43.google.com with SMTP id g135so575185wme.5
        for <linux-pci@vger.kernel.org>; Wed, 25 Aug 2021 16:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3MAlH9Z3LPdNW3FhnK6IP8SPx5XEfdG4Gct/zDrdpqo=;
        b=WI0b8YvFQs+K9VE8X+ijP74fOfZ0lX7Z9ezzFsPRrj2HB23UhKPx5hKsoOPg1CiMh/
         7FHzg5FAGHxmRkRvG5twCUW7VLOjFJ7y5pKAxNIeIY5ErhJb2ajG9SqDVGUpShVAamZp
         elJ1cFGVNnU4UaJFi9bxULgq1m8jPRebkz7zkl0dua0keT+iWE4xYg4oJCxM4kFTHsnZ
         P8mUiB/Tb0OjcHGe1Prza5nBNQJASiDRwunM31m0z7V7SpHkS3mHyWixBnkXev2KiEEX
         JRGWhncpZJ0yVlTtW57wQx2NTkYxtlRqXk05hFl2CNrWHEKgxn6rYNzpWDDYEIScqQNl
         7ezw==
X-Gm-Message-State: AOAM533NC0fd2ZOzAMk8S5tHHpvWHbCoWYJI9C+fHeLrlPzlTe6+0h8b
        Cu+I16G5/vcuNmD+kkRj34M=
X-Google-Smtp-Source: ABdhPJxSjf3hvZCJJMKdgbbtGu5WGtOsWlVZNdmNicuedgWCXmuy0y/2J14+pNKBbrq3Zzb+fXtLAw==
X-Received: by 2002:a05:600c:1457:: with SMTP id h23mr5572645wmi.143.1629932562048;
        Wed, 25 Aug 2021 16:02:42 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o21sm859767wms.32.2021.08.25.16.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:02:41 -0700 (PDT)
Date:   Thu, 26 Aug 2021 01:02:40 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Sasha Levin <sashal@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: Convert dynamic PCI resources sysfs objects
 into static
Message-ID: <20210825230240.GA439097@rocinante>
References: <20210825212255.878043-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825212255.878043-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof Hałasa, Sasha and Pali for visibility]

Hello Bjorn,

I wanted to add that Krzysztof Hałasa was able to find a bit of spare
time to test this series on his i.MX6 (Gateworks Ventana SBC), and
completed a number of tests (such as power-cycling the SoC, etc.)
without running into previous Oops and panic during boot.

The follow-up to this series will be changes specific to the Alpha
platform and legacy PCI attributes.

But since a majority of hardware platforms aren't really using legacy
PCI attributes these days (unless I am mistaken) and Alpha is not widely
used, fixing race condition in the PCI resource files converting them to
static sysfs objects would be a priority.

This will also make it easier to back-port this and other patches that
paved the way prior to this one the stable and LTS releases, especially
since these are widely used in popular distributions that tend to
back-port a lot too into their stable releases.

	Krzysztof
