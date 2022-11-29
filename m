Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2D63C41B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiK2Pru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 10:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiK2Prt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 10:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E93242F52
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 07:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669736813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fFCmZLrXuG3nOzoAi5zSMrtphr/E0e0mi6L5Ysip7bs=;
        b=XJTEMMF3KjAHdfrBWmFEUr5oMBk4Tka9oAPnvQ6ZdEHifuXLyi3p5u/nrWtcpwv+gwKgqh
        xM2D7/4WpTafr211nF5ljFhwk1aSZnO0Pnbkj9pFpRRdNA9m169oUGN199IhEVPj5u37Rg
        g/y7iPM+CWkrrIpSs/vpnCntJNmy8AA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-4jx28j7aORCq7rX5YFoRDw-1; Tue, 29 Nov 2022 10:46:51 -0500
X-MC-Unique: 4jx28j7aORCq7rX5YFoRDw-1
Received: by mail-il1-f199.google.com with SMTP id k11-20020a056e021a8b00b003030ec907c7so6445612ilv.10
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 07:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFCmZLrXuG3nOzoAi5zSMrtphr/E0e0mi6L5Ysip7bs=;
        b=YamySXSrYXMSRJEZZkT6o17bX0ImSsorRGCMUhgHHc9++wKz3+qoZaRp8gcHuwWURv
         YAW7tE084NRU8/0W+AkcLPpvpR1Bjl35/rvwcn4bstSewgsMMNrDqiqxnEAcoWtuDRxu
         B28YvEvLE+PGug62VPPHRVhvRZQz6ln0FCUIMbf9rPAhv6unAegFe3z3AZRZPw2TvseV
         wMdH2LWy+4KNwpeHJdZC2iFoSKUORXKT4LRF2ji/XaPWheBqxOpvRKXjiGX+VC3FWZpS
         113EeIs7W4oaTq7uRrc9Q4GmyUBAS0Z9l67Lq/K6vzdzzqTW6erlUMfY88+CEkDSHTl5
         Ql0A==
X-Gm-Message-State: ANoB5pmz69Wv6r1EwpD/XOwagYIpFygteY4WtEnRJaGXZ3xJovONDGM5
        WRgGLx5lpJn9W6pvuIiHgFAmErmQqZECgyLdfV2yXa2U+AtA4MMQzxXY7mNWmYMtKNTrC8YgRNN
        mGsaNUSqkWKA1xW/GKWDY
X-Received: by 2002:a05:6e02:be6:b0:302:e6b6:fd9 with SMTP id d6-20020a056e020be600b00302e6b60fd9mr14257113ilu.67.1669736810985;
        Tue, 29 Nov 2022 07:46:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7j+zagVezkPFKdeosduvl96bODPunsJxEODbsxODXnvhfbrTcyqV3XR56xEWVCwnGUb4bz1w==
X-Received: by 2002:a05:6e02:be6:b0:302:e6b6:fd9 with SMTP id d6-20020a056e020be600b00302e6b60fd9mr14257094ilu.67.1669736810566;
        Tue, 29 Nov 2022 07:46:50 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d74-20020a02624d000000b00363e4730a41sm5340971jac.175.2022.11.29.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:46:49 -0800 (PST)
Date:   Tue, 29 Nov 2022 08:46:46 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221129084646.0b22c80b.alex.williamson@redhat.com>
In-Reply-To: <Y4YgKaml6nh5cB9r@black.fi.intel.com>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
        <20221128203932.GA644781@bhelgaas>
        <20221128150617.14c98c2e.alex.williamson@redhat.com>
        <20221129064812.GA1555@wunner.de>
        <20221129065242.07b5bcbf.alex.williamson@redhat.com>
        <Y4YgKaml6nh5cB9r@black.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Nov 2022 17:07:21 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
> 
> On Tue, Nov 29, 2022 at 06:52:42AM -0700, Alex Williamson wrote:
> > On Tue, 29 Nov 2022 07:48:12 +0100
> > Lukas Wunner <lukas@wunner.de> wrote:
> >   
> > > On Mon, Nov 28, 2022 at 03:06:17PM -0700, Alex Williamson wrote:  
> > > > Agreed.  Is this convoluted removal process being used to force a SBR,
> > > > versus a FLR or PM reset that might otherwise be used by twiddling the
> > > > reset attribute of the GPU directly?  If so, the reset_method attribute
> > > > can be used to force a bus reset and perform all the state save/restore
> > > > handling to avoid reallocating BARs.  A reset from the upstream switch
> > > > port would only be necessary if you have some reason to also reset the
> > > > switch downstream ports.  Thanks,    
> > > 
> > > A Secondary Bus Reset is only offered as a reset_method if the
> > > device to be reset is the *only* child of the upstream bridge.
> > > I.e. if the device to be reset has siblings or children,
> > > a Secondary Bus Reset is not permitted.
> > > 
> > > Modern GPUs (including the one Mika is referring to) consist of
> > > a PCIe switch with the GPU, HD audio and telemetry devices below
> > > Downstream Bridges.  A Secondary Bus Reset of the Root Port is
> > > not allowed in this case because the Switch Upstream Port has
> > > children.  
> > 
> > I didn't see such functions in the log provided, the GPU in question
> > seems to be a single function device at 53:00.0.  This matches what
> > I've seen on an ARC A380 GPU where the GPU and HD audio are each single
> > function devices under separate downstream ports of a PCIe switch.  
> 
> Yes, this one is similar. There is a PCIe switch and then bunch of
> devices connected to the downstream ports. One of them being the GPU.
> 
> Sorry if I missed that part in the report.
> 
> There are typically multiple of these cards and they want to perform the
> reset seperately for each.

Maybe the elephant in the room is why it's apparently such common
practice to need to perform a hard reset these devices outside of
virtualization scenarios...
 
> > > See this code in pci_parent_bus_reset():
> > > 
> > > 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> > > 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> > > 		return -ENOTTY;
> > > 
> > > The dev->subordinate check disallows a SBR if there are children.
> > > Note that the code should probably instead check for...
> > > (dev->subordinate && !list_empty(dev->subordinate->devices))
> > > ...because the port may have a subordinate bus without children
> > > (may have been removed for example).
> > > 
> > > The "no siblings" rule is enforced by:
> > > 
> > > 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> > > 		if (pdev != dev)
> > > 			return -ENOTTY;
> > > 
> > > Note that the devices list is iterated without holding pci_bus_sem,
> > > which looks fishy.
> > > 
> > > That said, it *is* possible that a Secondary Bus Reset is erroneously
> > > offered despite these checks because we perform them early on device
> > > enumeration when the subordinate bus hasn't been scanned yet.
> > > 
> > > So if the Root Port offers other reset methods besides SBR and the
> > > user switches to one of them, then reinstates the defaults,
> > > suddenly SBR will disappear because the subordinate bus has since
> > > been scanned.  What's missing here is that we re-check availability
> > > of the reset methods on siblings and the parent when a device is
> > > added or removed.  This is also necessary to make reset_method
> > > work properly with hotplug.  However, the result may be that the
> > > reset_method attribute in sysfs may become invisible after adding
> > > a device (because there is no reset method available) and reappear
> > > after removing a device.
> > > 
> > > So the reset_method logic is pretty broken right now I'm afraid.  
> > 
> > I haven't checked for a while, but I thought we exposed SBR regardless
> > of siblings, though it can't be accessed via the reset attribute if
> > there are siblings.  That allows that the sibling devices could be soft
> > removed, a reset performed, and the bus re-scanned.  If there are in
> > fact sibling devices, it would make more sense to remove only those to
> > effect a bus reset to avoid the resource issues with rescanning SR-IOV
> > on the GPU.  
> 
> If I understand correctly they perform the reset just above the upstream
> port of the PCIe switch so that it resets the whole "card".

... and even to the extent that an entire PCIe hierarchy is being reset
rather than individual devices, let alone leaf buses.
 
> > > In any case, for Mika's use case it would be useful to have a
> > > "reset_subordinate" attribute on ports capable of a SBR such that
> > > the entire hierarchy below is reset.  The "reset" attribute is
> > > insufficient.  
> > 
> > I'll toss out that a pretty simple vfio tool can be written to bind all
> > the siblings on a bus enabling the hot reset ioctl in vfio.  Thanks,  
> 
> Sounds good but unfortunately I'm not fluent in vfio so I have no idea
> how this simple tool could be done :( Do you have any examples or
> pointers that we could use to try this out?

Unfortunately, if your goal is really to reset the whole switch, vfio
isn't going to help with that.  The vfio-pci driver only binds to
endpoints and a hot reset can be effected for a given endpoint, in the
presence of sibling devices which are also owned by the same user.
There's a rudimentary unit test below which implements this.

I think the reason we don't have a "reset_subordinate" attribute is
that there are a number of difficult issues in locking down an entire
hierarchy that go beyond what vfio does in validating the user's proof
of ownership for affected endpoints on a leaf bus.  Thanks,

Alex

#include <errno.h>
#include <libgen.h>
#include <fcntl.h>
#include <libgen.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/vfs.h>

#include <linux/ioctl.h>
#include <linux/vfio.h>

void usage(char *name)
{
	printf("usage: %s <iommu group id> <ssss:bb:dd.f>\n", name);
}

#define false 0
#define true 1

int main(int argc, char **argv)
{
	int i, j, ret, container, *pfd;
	char path[PATH_MAX];

	struct vfio_group_status group_status = {
		.argsz = sizeof(group_status)
	};

	struct vfio_pci_hot_reset_info *reset_info;
	struct vfio_pci_dependent_device *devices;
	struct vfio_pci_hot_reset *reset;

	struct reset_dev {
		int groupid;
		int seg;
		int bus;
		int dev;
		int func;
		int fd;
		int group;
	} *reset_devs;

	if (argc < 3) {
		usage(argv[0]);
		return -1;
	}

	printf("Expect %d group/device pairs\n", (argc - 1)/2);

	reset_devs = calloc((argc - 1)/2, sizeof(struct reset_dev));
	if (!reset_devs)
		return -1;

	for (i = 0; i < (argc - 1)/2; i++) {
		ret = sscanf(argv[i*2 + 1], "%d", &reset_devs[i].groupid);
		if (ret != 1) {
			usage(argv[0]);
			return -1;
		}

		ret = sscanf(argv[i*2 + 2], "%04x:%02x:%02x.%d",
			     &reset_devs[i].seg, &reset_devs[i].bus,
			     &reset_devs[i].dev, &reset_devs[i].func);
		if (ret != 4) {
			usage(argv[0]);
			return -1;
		}

		printf("Using PCI device %04x:%02x:%02x.%d in group %d "
	               "for hot reset test\n", reset_devs[i].seg,
		       reset_devs[i].bus, reset_devs[i].dev,
		       reset_devs[i].func, reset_devs[i].groupid);
	}

	container = open("/dev/vfio/vfio", O_RDWR);
	if (container < 0) {
		printf("Failed to open /dev/vfio/vfio, %d (%s)\n",
		       container, strerror(errno));
		return container;
	}

	for (i = 0; i < (argc - 1)/2; i++) {
		snprintf(path, sizeof(path), "/dev/vfio/%d",
			 reset_devs[i].groupid);
		reset_devs[i].group = open(path, O_RDWR);
		if (reset_devs[i].group < 0) {
			printf("Failed to open %s, %d (%s)\n",
			path, reset_devs[i].group, strerror(errno));
			return reset_devs[i].group;
		}

		ret = ioctl(reset_devs[i].group, VFIO_GROUP_GET_STATUS,
			    &group_status);
		if (ret) {
			printf("ioctl(VFIO_GROUP_GET_STATUS) failed\n");
			return ret;
		}

		if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
			printf("Group not viable, are all devices attached to vfio?\n");
			return -1;
		}

		ret = ioctl(reset_devs[i].group, VFIO_GROUP_SET_CONTAINER,
			    &container);
		if (ret) {
			printf("Failed to set group container\n");
			return ret;
		}

		if (i == 0) {
			ret = ioctl(container, VFIO_SET_IOMMU,
				    VFIO_TYPE1_IOMMU);
			if (ret) {
				printf("Failed to set IOMMU\n");
				return ret;
			}
		}

		snprintf(path, sizeof(path), "%04x:%02x:%02x.%d",
			 reset_devs[i].seg, reset_devs[i].bus,
			 reset_devs[i].dev, reset_devs[i].func);

		reset_devs[i].fd = ioctl(reset_devs[i].group,
					 VFIO_GROUP_GET_DEVICE_FD, path);
		if (reset_devs[i].fd < 0) {
			printf("Failed to get device %s\n", path);
			return -1;
		}
	}
	getchar();

	reset_info = malloc(sizeof(*reset_info));
	if (!reset_info) {
		printf("Failed to alloc info struct\n");
		return -ENOMEM;
	}

	reset_info->argsz = sizeof(*reset_info);

	ret = ioctl(reset_devs[0].fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO,
		    reset_info);
	if (ret && errno == ENODEV) {
		printf("Device does not support hot reset\n");
		return 0;
	}
	if (!ret || errno != ENOSPC) {
		printf("Expected fail/-ENOSPC, got %d/%d\n", ret, -errno);
		return -1;
	}

	printf("Dependent device count: %d\n", reset_info->count);

	reset_info = realloc(reset_info, sizeof(*reset_info) +
			     (reset_info->count * sizeof(*devices)));
	if (!reset_info) {
		printf("Failed to re-alloc info struct\n");
		return -ENOMEM;
	}

	reset_info->argsz = sizeof(*reset_info) +
                             (reset_info->count * sizeof(*devices));
	ret = ioctl(reset_devs[0].fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO,
		    reset_info);
	if (ret) {
		printf("Reset Info error\n");
		return ret;
	}

	devices = &reset_info->devices[0];

	for (i = 0; i < reset_info->count; i++)
		printf("%d: %04x:%02x:%02x.%d group %d\n", i,
		       devices[i].segment, devices[i].bus,
		       devices[i].devfn >> 3, devices[i].devfn & 7,
		       devices[i].group_id);

	printf("Press any key to perform reset\n");
	getchar();
	printf("Attempting reset: ");
	fflush(stdout);

	reset = malloc(sizeof(*reset) + (sizeof(*pfd) * reset_info->count));
	pfd = &reset->group_fds[0];

	for (i = 0; i < reset_info->count; i++) {
		for (j = 0; j < (argc - 1)/2; j++) {
			if (devices[i].group_id == reset_devs[j].groupid) {
				*pfd++ = reset_devs[j].group;
				break;
			}
		}

		if (j == (argc - 1)/2) {
			printf("Group %d not found\n", devices[i].group_id);
			return -1;
		}
	}

	reset->argsz = sizeof(*reset) + (sizeof(*pfd) * reset_info->count);
	reset->count = reset_info->count;
	reset->flags = 0;

	ret = ioctl(reset_devs[0].fd, VFIO_DEVICE_PCI_HOT_RESET, reset);
	printf("%s\n", ret ? "Failed" : "Pass");

	return ret;
}

