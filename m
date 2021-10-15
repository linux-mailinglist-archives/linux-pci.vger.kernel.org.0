Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8C42E651
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 03:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhJOB5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 21:57:41 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:41535 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhJOB5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 21:57:40 -0400
Received: by mail-lf1-f50.google.com with SMTP id u21so31836479lff.8;
        Thu, 14 Oct 2021 18:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IpSaQEoG/BUW0J8Sx8FaAR1StsiXGFl1oWEx3RqNFrc=;
        b=CisFiM0kfzqffgg5YJnU8l8n389+vzp9DJ6fCyGsTBRqDJ1RZ8Okfjg6xk6OuBFsUE
         8hSnWHpmltiIk8DqZGiprplOLMIb9kbbeuzVVOC01Xta7kfj6CDmu+v7l3x0v+jexOde
         9/I7wx7D23+wgesocSGYIII4zanjYrJoc+Rlug/BIEUMko1fZtWtk8xOYyOw5PM+siwh
         TmvzCWo+iSFq8LwCIwcRH+szd8uvpFfTveyWO/p6hACN9q03y8XhZ9BrhV4dPMgWffSO
         cGb+PklTCHlybdyMBH6BSUUGWeA206WhhSDjLQ/ciIkFVPogTeTXMahQgFJ9Ygfnhhg/
         6qKA==
X-Gm-Message-State: AOAM531L/fAlgIkhtk0HdPlUj0yeWCzH/WlaKWDld8mFkF2TJNmkba0v
        LW9XU232BZq7AytXc6x6o3GSx0Mln8I=
X-Google-Smtp-Source: ABdhPJyaBhouAikuEyMYudVHw193Qnh6ZgUDl/KwhvAfT3qWqayax6iAPfl3SztPNQipmBrDj7gTbg==
X-Received: by 2002:a19:441a:: with SMTP id r26mr8202587lfa.365.1634262934027;
        Thu, 14 Oct 2021 18:55:34 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w13sm370241lft.94.2021.10.14.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 18:55:33 -0700 (PDT)
Date:   Fri, 15 Oct 2021 03:55:32 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP
Message-ID: <YWjflHn2pVW4IRyM@rocinante>
References: <20211014141859.11444-1-kelvin.cao@microchip.com>
 <20211014141859.11444-5-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014141859.11444-5-kelvin.cao@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jakub for visibility]

Hi,

> ENOTSUPP is not a SUSV4 error code, and the following checkpatch.pl
> warning will be given for new patches which still use ENOTSUPP.
> 
>     WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 
> See the link below for the discussion.
> 
>   https://lore.kernel.org/netdev/20200511165319.2251678-1-kuba@kernel.org/

This makes me wonder whether we should fix other occurrences of ENOTSUPP we
have in the PCI tree, as per:

  Index File                                       Line Content
      0 drivers/pci/msi.c                          1304 *  -ENOTSUPP otherwise
      1 drivers/pci/msi.c                          1316 return -ENOTSUPP;
      2 drivers/pci/pcie/dpc.c                      355 return -ENOTSUPP;
      3 drivers/pci/setup-res.c                     421 return -ENOTSUPP;
      4 drivers/pci/setup-res.c                     433 return -ENOTSUPP;
      5 drivers/pci/pci.c                          3600 * Returns -ENOTSUPP if resizable BARs are not supported at all.
      6 drivers/pci/pci.c                          3610 return -ENOTSUPP;
      7 drivers/pci/switch/switchtec.c              330 return -ENOTSUPP; \
      8 drivers/pci/switch/switchtec.c              616 return -ENOTSUPP;
      9 drivers/pci/switch/switchtec.c              824 return -ENOTSUPP;
     10 drivers/pci/switch/switchtec.c             1559 return -ENOTSUPP;
     11 drivers/pci/controller/dwc/pcie-tegra194.c 2244 return -ENOTSUPP;

What do you think Bjorn? Jakub?

	Krzysztof
