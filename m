Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5B3BA640
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 01:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGBXTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 19:19:42 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36779 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBXTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 19:19:42 -0400
Received: by mail-lj1-f179.google.com with SMTP id a6so15500631ljq.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 16:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qu0nbdOe/wpwCFdN17eHg9xOzM34/qOm5hBZxo+WoYw=;
        b=IFjlWRopmwy9qeND7bGKPpxEHfxbXxAdM1RvRAYEWhFWrpJPzKZxBzUzw1YU3+IjxV
         eOJpX4CzhISyWQ/tiGJ9PlNBgwYbV5JzcpIDQxi9/waIIe2JGZYbt46fXc7he+5IS+Ml
         MYxsHdXa20xWw+9VnCob2blaHAcFTLAl4y2+19nr3AaYCxQTVrLSQbkizQKZ7PKwiG8s
         0b5MeHOhM2Koom3qBQwfBE8B07Nhq4bUyH6st3zkjxpuZ9Oepi2dS+fHKgg19dPnSkKN
         CE93sbvuVTKnQm21zb69Mzg5m5Ky0sPQOzrxNebJ8y/J8dNVUYp1gng7rBJs6i4OmeD2
         eRUw==
X-Gm-Message-State: AOAM530WCC8mSxnrQWA5Tvf5i0c5nPxcRXXkSrPCLobriaVOazCbWyH1
        36aOYSq2e4RU/Y0/le6xMU8=
X-Google-Smtp-Source: ABdhPJwrV3HWg1cAE9JY7ZNRMnhaNsXQMhYs3mKrcrfO2CpqhSUZmzcXT1j3aqApDZf/GboA6JLU7g==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr1423468ljf.490.1625267828084;
        Fri, 02 Jul 2021 16:17:08 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q6sm392203lfh.246.2021.07.02.16.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 16:17:07 -0700 (PDT)
Date:   Sat, 3 Jul 2021 01:17:06 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hotplug: Fix kernel-doc formatting and add
 missing documentation
Message-ID: <20210702231706.GA405540@rocinante>
References: <20210702221804.1668189-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210702221804.1668189-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

This version has been superseded by v3 where I added more
hotplug-related kernel-doc fixes.

	Krzysztof
