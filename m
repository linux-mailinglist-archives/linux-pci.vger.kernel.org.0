Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62C392E5D
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhE0MyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:54:11 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:54998 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhE0MyD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 08:54:03 -0400
Received: by mail-pj1-f46.google.com with SMTP id g24so371660pji.4;
        Thu, 27 May 2021 05:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSLce6wfskplcriMMt7LYgVCTftVP4hejmuqS/PjYeA=;
        b=R5FAl8IJ6yIERbeMPQGOOcMHnl39esZYVjgKG8eKGjXatrN4b2C/wZaVEjP+wjzTfg
         oST9qhen2teQTrSW49DwMtQHE14oQw4SI25Nrd4A2nhynDVVve6Zlwz8M9ofVrZ6mOc3
         yM4EXJjkAU5Xy6Lb8QoUyqnbbBMAc3RQ8D/rFfNuV4ZEPLAFQLPhXKoybvJlqi1VmswO
         /vyTEWFHMZZUEGZoJw9Ibsub9YSN95X9KzDaKNl2tozK10bcT0b3r8GSkL9J+uRCnwL0
         sWXemDXADyGEb8K+JQe4IdINa5vqebAIAKTnlSyF7IjqLETeLN6LQe/KZC310ZEIcTX0
         fZhQ==
X-Gm-Message-State: AOAM532AGMRBaM2gWDpz2buwUuc0A/iJ+yuivtOgdUAkoCqGg9d887h2
        NN0KsBpAyYySSjQmL9tqn4E=
X-Google-Smtp-Source: ABdhPJx1ZaCIn+lmTaF0DP0ifbMl+cQ7eYVXDGk1Tobkj4YnzLCxekE5eYmJWIOQh6p/5I2bwm/j7g==
X-Received: by 2002:a17:90b:3710:: with SMTP id mg16mr7673826pjb.228.1622119949835;
        Thu, 27 May 2021 05:52:29 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d10sm1896660pfo.65.2021.05.27.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:52:29 -0700 (PDT)
Date:   Thu, 27 May 2021 14:52:18 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Om Prakash Singh <omp@nvidia.com>, vidyas@nvidia.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com
Subject: Re: [RESEND PATCH V1 0/5] Update pcie-tegra194 driver
Message-ID: <20210527125218.GA221677@rocinante.localdomain>
References: <20210527115246.20509-1-omp@nvidia.com>
 <20210527120015.GA213718@rocinante.localdomain>
 <f3a04232-8a2e-3231-6ce1-260b8400383a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3a04232-8a2e-3231-6ce1-260b8400383a@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

[...]
> I suggested resending it because the initial version had two cover
> letters and two copies of the same patch. It took me a minute to figure
> out what was what. So just ignore the first series.

Ah, OK.  No worries then.

	Krzysztof
