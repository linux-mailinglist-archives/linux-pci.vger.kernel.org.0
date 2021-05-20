Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5004A38B287
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhETPGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 11:06:51 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:43702 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhETPGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 11:06:50 -0400
Received: by mail-ej1-f41.google.com with SMTP id l4so25801140ejc.10;
        Thu, 20 May 2021 08:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J0+ARndAuXCdmFIX0f+gwEMiBKr1+CtA3TI2Q0A3VZ0=;
        b=tjgcFUHY08OoAXFT59Dk9L2YkycGm/YkE2GyX3qspzHJumla1xjTKzbSFrZeNMdJMW
         MqLC42ChKfUGE0Cq5zbVZLvKqIadCmaIgieauRQiF49o4ZWjlYYq70b2rNICu+SOOjpt
         Dggny3DpsbD24MLpg7tM0Fr627iZeHB1muuNvSDnVnsQteXX51fblP3/KzFnKOXCfbxp
         g3HLbty/FTTuzW1nmsXtxEn/rTiI9PHzpGnaGkX4hqtvktffnh8RBhvQtOTLmwfCfX5Z
         nsMozmYslsAdIPENRUpQN2EQLmMZotoGWvnWGzBXsEZfKlcFNMn1dVCpe7MIh7CYJZYb
         7iUA==
X-Gm-Message-State: AOAM531SGw4kbUPRt4FJfkvEHk+gFb0EF4KNal6wo5QQ0X0LT/bLx0if
        7qa8856tFUQ4lAeEHtbnbg8=
X-Google-Smtp-Source: ABdhPJzIH6GDrIJx8CBEaa9wHjXjPXzQvWcl7jILYFw5o6nmrQx3X8Bg+Eo8kETA5bZLXFGwthfYeQ==
X-Received: by 2002:a17:907:2855:: with SMTP id el21mr5214067ejc.153.1621523127999;
        Thu, 20 May 2021 08:05:27 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m12sm1362275edc.40.2021.05.20.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:05:27 -0700 (PDT)
Date:   Thu, 20 May 2021 17:05:26 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/7] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210520150526.GB641812@rocinante.localdomain>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
 <20210519235426.99728-3-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519235426.99728-3-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

[...]
> +int pcie_reset_flr(struct pci_dev *dev, int probe)
> +{
> +	u32 cap;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pcie_flr(dev);
> +}

Similarly to my suggestion in the first patch in the series, perhaps
using a boolean here would be an option.

Having said that, the following existing functions aren't doing it, so
for the sake of keeping things consistent it might not be the best
option, as per:

 static int pci_af_flr(struct pci_dev *dev, int probe)
 int nvme_disable_and_flr(struct pci_dev *dev, int probe)

Krzysztof
