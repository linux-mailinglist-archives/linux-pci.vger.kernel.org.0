Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852AE124CBB
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLRQIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 11:08:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfLRQIm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 11:08:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so2419236wmc.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2019 08:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o5X12+OnlTrR6hQB7btD1TwyQhH770WeXItNc7qt5zA=;
        b=vGdwPfRl1Ha9VhwGDZb29pGKHmrCLBjEh/aU/lWfjiA+Es/jr7ZphzP4HzPPmjTJx+
         JSehVhXPNzXdOHN1KvgmcYfeFj+EOqqLkQfTn7w+aSzsmY9sA/Phabc6P4xORTt9/1CX
         ZeJvajjFb7Aa2pPQS2rmj8CC2WfmH3g8R6Icy6BCtWh0myJTrzSd94GfQGUovkp6jd2B
         rT+HoiZRDI9Poe0mNpRZQO9dQfwLmHSchdxzCs4OzzEO+QNZJtdaxkDjf9S6U0pGGXCC
         uBxrbddT9q0O1xSpIKLYhBMvxSFqGMIVi9YEcXDMHetlYODSFxx8S1+dGvzAMam0zV9q
         MZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5X12+OnlTrR6hQB7btD1TwyQhH770WeXItNc7qt5zA=;
        b=GPz4hvPQRDRRK4PT9n9VxvlMyyBA2qZRrMmmf2NR0ntgw1/PiLpECaA9Hh26l6/vKH
         Gvpnh07tW+6n0zQE1IY1I16D0xHnkH86e3OfVPHxMG9w7vgXWmW45nWC8uUKKrd3W+0G
         KQIV/Ugs4jJdW/Jgy4LeGQdJDA5WAsm4otE0MGq+WHZplu7wX+DCnPUawr0JQMLAnUjW
         jeEc5W8TKy3gSfKJEp8IztSxLq86FhIkqqXzSUjtDIaKvfcrYPyHZTbtXYLRjpa13wmF
         sZiLeC55RJYeRzS1su48EvGr7XwH7eWHuIPm2c1PAHi/u5PL13MhhnLqOOvvLNzeumRW
         Ofcw==
X-Gm-Message-State: APjAAAU/tTKJPZOnZ0pdVrRLGF9TcTyQvJG5xDezqvOR5toIYkYZ1uTC
        /Zk9TYs/4GSWbc/UIpgkn3veLA==
X-Google-Smtp-Source: APXvYqzGNVeQ/R7JR9UNdXnpKZSm9sCG7ntxjETJuNIvtVXZ9l8S+gdw6OnN9egWqIdDF5D4ZyEZUA==
X-Received: by 2002:a05:600c:22c8:: with SMTP id 8mr3940980wmg.178.1576685320145;
        Wed, 18 Dec 2019 08:08:40 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id c5sm2949884wmb.9.2019.12.18.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:08:39 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:08:34 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Propate ssid_bits
Message-ID: <20191218160834.GG2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-9-jean-philippe@linaro.org>
 <466bbc57-79d4-274c-67bc-4ed591da9968@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466bbc57-79d4-274c-67bc-4ed591da9968@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 17, 2019 at 06:07:26PM +0100, Auger Eric wrote:
> Hi Jean,
> 
> On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> 
> s/Propate/Propagate in the commit title.
> > Now that we support substream IDs, initialize s1cdmax with the number of
> > SSID bits supported by a master and the SMMU.
> > 
> > Context descriptor tables are allocated once for the first master
> > attached to a domain. Therefore attaching multiple devices with
> > different SSID sizes is tricky, and we currently don't support it.
> > 
> > As a future improvement it would be nice to at least support attaching a
> > SSID-capable device to a domain that isn't using SSID, by reallocating
> > the SSID table.
> Isn't that use case relevant (I mean using both devices in a non SSID
> use case). For platform devices you can work this around with FW but for
> PCI devices?

Normally each device gets its own domain. Especially since PASID is a PCI
Express capability, I expect them to be properly isolated with ACS, each
with its own IOMMU group. So I don't think this is too relevant for the
moment, it would be a quirk for a broken system.

Thanks,
Jean
