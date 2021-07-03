Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005503BA92E
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhGCPVV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 11:21:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:40718 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCPVV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 11:21:21 -0400
Received: by mail-ed1-f50.google.com with SMTP id t3so17422698edc.7
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 08:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f6iDqAoL69bX6HpGUxbgATdVG2ZlghhW7qjDAoyRWtc=;
        b=nmbA3rY3fzHhQB24iH+GHjhCrMfIQ7BheW2cbfrzbw/f+IMDnQnNUj+ofu1yiV7Wkm
         zBF8aRPzlQajV4N9AGmQeQEJbkzykAOLpfSWfMINgvymElEJxnbbWwRl7YCEiLhHlC8H
         cQijAln/5ZlYQikYBMbocgQLB5vsaomDPjqOJeIAb4m/beUKM51EWTUp/iXNq1ISVxDU
         55IEZHVM27tzsBh2ZKWbz0sjpvcmlB8lAFyxbLuJtoZitnImkIsyIHurflXwCYRJofS2
         qBcLip4bK12ZcONB5Zd2DugxoM7Ezv8zOJTvQ3Y0UkXCzrDcE3HMNWP69pYW9IdbihLY
         bxEQ==
X-Gm-Message-State: AOAM533v0DXfPXWtvTAhZy7lOo0DfzvPpwvdXJRNf7r836zEFk3CIDBv
        lTGgoB+P7Y2L6qQARlDGFoU=
X-Google-Smtp-Source: ABdhPJxkB2xRIU1yUQc1AtAWabjpxjJcCXb8gEXZ4/xpAtXOt5uNj7MAozcNfb1DQf98cTIwNXuRag==
X-Received: by 2002:a05:6402:3082:: with SMTP id de2mr4339569edb.9.1625325525931;
        Sat, 03 Jul 2021 08:18:45 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g8sm2703589edw.89.2021.07.03.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 08:18:45 -0700 (PDT)
Date:   Sat, 3 Jul 2021 17:18:44 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] PCI: iproc: Fix a non-compliant kernel-doc
Message-ID: <20210703151844.GB445417@rocinante>
References: <20210702204022.1654290-1-kw@linux.com>
 <9fd51762-ade4-619a-dd14-6194e11f38eb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fd51762-ade4-619a-dd14-6194e11f38eb@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

This patch has been superseded by the following series:
 https://lore.kernel.org/linux-pci/20210703151306.1922450-1-kw@linux.com/T/

New patch as been reworked as per feedback from Lukas Wunner.  I sincerely
apologise for all the commotion with these trivial patches.

	Krzysztof
