Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F51722EE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 01:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfGWXYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 19:24:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34031 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGWXYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 19:24:17 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so85604789iot.1;
        Tue, 23 Jul 2019 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKl/UO0N722owerZ7uvxTX5GkSBg77fwKXsdJcJ89jw=;
        b=W/azuwYc5RF0CLl2tNylYs96mx//cO/dqpDHVSi7Tx5ZOsQpKCKderAm4PQFHc0Wlo
         CA5ArjI4C7GISOF1gvZGapcPsBoiGrJOBC+Hhg+kEbHGOkqJwf7WmqohdzXTMSFD4asg
         F6J9p+jkhfqSQTcRZWUIaMENq/j+pKJ+jSImB11LK7FMkGbjQP6eKY96aTkBo+aRrj0G
         E+KI0xJHmHtf5Y32Fi5SvSZzpRUKwPLlGaZgi1exYiopX5P0DSZGynbyT1+s+bHOq+3Y
         ZlSyTX7uG1STgviFa2wV6W6P2JmZpuODDmKO/5Mv5vrX6vSqd/fzi+zmaeVL1AYKEOHC
         AhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKl/UO0N722owerZ7uvxTX5GkSBg77fwKXsdJcJ89jw=;
        b=g4CWHeznJBgIRZIaiiD/7YGe/1ClqlUuh9UrElpvoCyk7HhORCHsmcYHoLDlEZdo8A
         YKWJueS9bX8Ro3IQUQdKUhLEScSkPrUtEy4C69A1YZb3Frz38PG8c31rehfIBRrwDfy3
         nwuRmfFXOtS1Pe9RxvDNCZsVA4npylp7QXdOa7EJvcilCxV4RUAu/Dh9kijrFpk4MTTw
         N8RVClfisOZNm637gPIMxqSN5+gajpp155xVmc7ywDkj5iHQ5FI2aXdOYLR7rt5/elmH
         i6bpGvWiJdsrrSQrpikPNQTZZZXdReiGeImJSW9xmruDtAt5GEDdrItgDoWG4wQhPeiJ
         /37g==
X-Gm-Message-State: APjAAAXAJ812OQeQLHBaT+7OwC9j4wXDFM42jX7rULmAVqfqShxyWC3b
        YDLH/+qHs+BpAmKZ5U5rnrg=
X-Google-Smtp-Source: APXvYqzEGthFomN6apTXtcZGPfFB3acwEY2rLrsGnZT81G/G8D+Oq6T6j0D+KB0q5WG7jl1jc5K5rQ==
X-Received: by 2002:a02:5ec9:: with SMTP id h192mr79609871jab.25.1563924257148;
        Tue, 23 Jul 2019 16:24:17 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s10sm106218264iod.46.2019.07.23.16.24.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 16:24:16 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:24:14 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 00/11] PCI: Move symbols to drivers/pci/pci.h
Message-ID: <20190723232414.GB16776@JATN>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190723230701.GA47047@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723230701.GA47047@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 23, 2019 at 06:07:01PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 11, 2019 at 04:23:30PM -0600, Kelsey Skunberg wrote:
> > Move symbols defined in include/linux/pci.h that are only used in
> > drivers/pci/ to drivers/pci/pci.h.
> > 
> > Symbols only used in drivers/pci/ do not need to be visible to the rest of
> > the kernel.
> > 
> > Kelsey Skunberg (11):
> >   PCI: Move #define PCI_PM_* lines to drivers/pci/pci.h
> >   PCI: Move PME declarations to drivers/pci/pci.h
> >   PCI: Move *_host_bridge_device() declarations to drivers/pci.pci.h
> >   PCI: Move PCI Virtual Channel declarations to drivers/pci/pci.h
> >   PCI: Move pci_hotplug_*_size declarations to drivers/pci/pci.h
> >   PCI: Move pci_bus_* declarations to drivers/pci/pci.h
> >   PCI: Move pcie_update_link_speed() to drivers/pci/pci.h
> >   PCI: Move pci_ats_init() to drivers/pci/pci.h
> >   PCI: Move ECRC declarations to drivers/pci/pci.h
> >   PCI: Move PTM declaration to drivers/pci/pci.h
> >   PCI: Move pci_*_node() declarations to drivers/pci/pci.h
> > 
> >  drivers/pci/pci.h   | 48 ++++++++++++++++++++++++++++++++++++++++++---
> >  include/linux/pci.h | 47 --------------------------------------------
> >  2 files changed, 45 insertions(+), 50 deletions(-)
> 
> Hi Kelsey,
> 
> I didn't get these applied before v5.3-rc1, so now they don't apply
> cleanly.  Would you mind refreshing them and posting a v2 that does
> apply to my "master" branch (v5.3-rc1)?
> 
> Bjorn

Hi Bjorn,

I can absolutely do that. I'll have v2 sent out soon.

-Kelsey
