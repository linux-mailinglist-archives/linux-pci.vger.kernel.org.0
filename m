Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B5440F99F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbhIQNzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 09:55:08 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33544 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbhIQNzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 09:55:07 -0400
Received: by mail-wr1-f47.google.com with SMTP id t18so15392141wrb.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 06:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Wu81rpeohFS7cNOKoLsTxbjwHv1IwKol2KMC+B4ipQ=;
        b=zU6DYshztCm1XZeXKf7ZCFsjFC4CpECh5pccNJI5Wtv/RVD7+3IuEF0XQXgnkN5ywp
         b4CvRE4J52R/AupPaWmMaeEiGng8AHzfMqsmhu3oZXjViU078+xQTI+vfwtQ7FHi5HaZ
         xyeyv7IvdAwjJj0u4UUC+XhLYq0mci8ZLYP+E9UvG78qFHiLo0ybEd2PlZfa6QRRV8jE
         Iwtl5xW9SfH8TnG8Gk0LIZrpE/fPJBj4+RxYik3oDmG4sGVzz05bi1BPmbMjpyLhExUw
         KdmRZFsZb6z1e+noyMvB1fwlFsXajSspvQfgp1cEYtEbTl8NZ5FaIDsaL+Ma6pf2a5Qb
         0C0Q==
X-Gm-Message-State: AOAM533yQi9oz/fJn89usH2Fh2p7JRg4WaKuV0f4QEzkRXdE9aV1TptE
        nzvy11abw/GR1FGiguoZ3RiBNzsvoYA=
X-Google-Smtp-Source: ABdhPJyHrp0G4Z/qNF+F8ThCw5M50qZb1oM50ToVpPOGekEEGTx2/ZGMB+22om2WwUCC9xwvlqfz7g==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr12525863wru.178.1631886824446;
        Fri, 17 Sep 2021 06:53:44 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j7sm8527732wrr.27.2021.09.17.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 06:53:43 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:53:42 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Add simple sanity check to pci_vpd_size()
Message-ID: <20210917135342.GB1518947@rocinante>
References: <135abde5-dc5b-826e-e20d-0f53bf32d2dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <135abde5-dc5b-826e-e20d-0f53bf32d2dc@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiner,

[...]
> Instead let's add a simple sanity check on the number of found tags.
> A VPD image conforming to the PCI spec can have max. 4 tags:
> id string, ro section, rw section, end tag.

It's always nice to check if something is compliant with the specification.

Would you be able to either cite this part of the official specification or
mention where to find it?  Like we do in other such changes related to some
official standards, mainly for posterity to benefit others that might look
at this commit in the future.

[...]
> +		/* We can have max 4 tags: STRING_ID, RO, RW, END */
> +		if (++num_tags > 4)
> +			goto error;

Do we want to let someone know that their device (or a device they might
have in the system) has non-compliant and/or malformed VPD which is why we
decided to return an error?  I wonder if this would help with
troubleshooting or just simply had some informative value.  So perhaps
a warning or debug level message?  What do you think?

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
