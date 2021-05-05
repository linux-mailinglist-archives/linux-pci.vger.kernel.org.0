Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C66373F4E
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhEEQN3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 12:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233835AbhEEQN1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 12:13:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D06866121F;
        Wed,  5 May 2021 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620231151;
        bh=KZm7yQGywVK8+8l4+qKm8VTVElQ6WB0e3JhAjGn4BWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYO2gA/RjazCgRz1g7yhO4CB2gyuRCtOAH3ety+9mhsGy1GobIr3kUQkb+WSDf6rc
         n9Hj+I7mrWC2SLEgkqWVr4huGwdVBrBXpKc1tSNpTjGI4CZyrntzlYXWuMlgsDdDh+
         HJw/TSZlK7xCRrHIbRmDQMWyQLCWV1V5efXas4nd4htJnX9C9JriwvabqtciPPwudX
         h7GkWo1lV2BnEJtnQeYaoGPW3/AGHNFY/pJ7riWCMp2Y7HKDfNsxxWsnY4OQGrstxz
         omgrMyqu/amgAoePmeYxGkgAa78qNUUE7QUdA+ADgtgRzBqV8qY6aMNsoWrfUZqrQA
         qsIardN9ia+pw==
Date:   Wed, 5 May 2021 09:12:28 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add support for PCIe SSD status LED management
Message-ID: <20210505161228.GC912679@dhcp-10-100-145-180.wdc.com>
References: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 16, 2021 at 03:20:10PM -0400, Stuart Hayes wrote:
> This patch adds support for the PCIe SSD Status LED Management
> interface, as described in the "_DSM Additions for PCIe SSD Status LED
> Management" ECN to the PCI Firmware Specification revision 3.2.
> 
> It will add a single (led_classdev) LED for any PCIe device that has the
> relevant _DSM. The ten possible status states are exposed using
> attributes current_states and supported_states. Reading current_states
> (and supported_states) will show the definition and value of each bit:

There is significant overlap in this ECN with the PCIe native enclosure
management (NPEM) capability. Would it be possible for the sysfs
interface to provide an abstraction such that both these implementations
could subscribe to?
 
> >cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
> ok                              0x0004 [ ]
> locate                          0x0008 [*]
> fail                            0x0010 [ ]
> rebuild                         0x0020 [ ]
> pfa                             0x0040 [ ]
> hotspare                        0x0080 [ ]
> criticalarray                   0x0100 [ ]
> failedarray                     0x0200 [ ]
> invaliddevice                   0x0400 [ ]
> disabled                        0x0800 [ ]
> --
> supported_states = 0x0008

This is quite verbose for a sysfs property. The common trend for new
properties is that they're consumed by programs as well as humans, so
just ouputing a raw number should be sufficient if the values have a
well defined meaning.
