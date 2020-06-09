Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33911F36BE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFIJPa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 9 Jun 2020 05:15:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgFIJP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 05:15:28 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N2m7O-1ixPAe2F7E-0132Hu; Tue, 09 Jun 2020 11:15:24 +0200
Received: by mail-qt1-f172.google.com with SMTP id z1so17033042qtn.2;
        Tue, 09 Jun 2020 02:15:24 -0700 (PDT)
X-Gm-Message-State: AOAM530RS4NuecT0s1oQr4x5f7MC0L6huT56ymvbTGx6JeZJh5qu27pn
        lQOZlupwS82j3k6qHBlk9tTZB4uQOL4CgcrbNuY=
X-Google-Smtp-Source: ABdhPJwLEIiew7LT85XJ7YMwfJX7yhLUFVtBnCDqoIKOxdCKDHjqNlOaWp8DLPqmET9skm0FQ81wStwRswqY7BJG62c=
X-Received: by 2002:ac8:4742:: with SMTP id k2mr27989059qtp.304.1591694122865;
 Tue, 09 Jun 2020 02:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200608164148.GA1394249@bjorn-Precision-5520> <bcf0a327-87b5-01ff-2f9c-ec6a6bd6c738@linaro.org>
In-Reply-To: <bcf0a327-87b5-01ff-2f9c-ec6a6bd6c738@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Jun 2020 11:15:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a38bhE_VO_eVcsfsGKgED=gmSEntQmrhwbLkeA6Si0qaw@mail.gmail.com>
Message-ID: <CAK8P3a38bhE_VO_eVcsfsGKgED=gmSEntQmrhwbLkeA6Si0qaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:kGYb3jMmETbHk7ETfChJPcg/kM3FCJJZyPXx2XC8g5Ud8G3UIHU
 xevtugFVfk44vd4itd6CeUSdhZ1TR+dMXfGOdfYN8RFRs0t2r3J7BtVJRhJasrZihguscsm
 TtxP+C2qRGuRL/nPub9KTWp9a/JVDQqUdXz+RMVjRKDW9tPyM8C55HldJstRePmeIPeHqDO
 A9fsJQT/cC7nc471uW3jQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QGEsjw7JNoI=:qdRg51FIcOUv/GbrX7H8NU
 du6LH6NLpibryVn24IY3CrezHYu8HbUwKgMnamWMKV5Ntqwy148m/mbIv8mUBPRbNlRZHf6sF
 Qw3tYHvhV25Y99dTHUj1JrGTZj8m/Qh2kVzgMj06tPNJ4mFHKvFxGbEFEKuk/bxKZGQ4JdJzB
 6vBGIHT6UvmRqALLZNgfEVvAWcWHuR7fIAwcAkzSqXIPGZQNKhmnMIfltPQ5xbFz+20IMUk7T
 E25RJNPZ1CO3+1pbZIaN8ZvcjVrjYQti647DdUfsCfboku7bJY4jFVbPD/u4mWquoz3sug7Ve
 xFWXqGW0EvAYinaE5IdIB7dAn4Wjk3Xo6cZKPq7RPK+2WIsT1QAxQn76hUN1afVjftxFPDXFv
 OsIveDASndAX/kKKR+nSnCSC8H65BlRrqcvNr700bS7S6wPES0bqO2FP3fVzy0/WZbE0plOE3
 pyywpEWtC02Pdnzu3sW/ftCMaHZgDALBYj6fwh4PdwMkKL3qmxtMkJ0OIpC/DsylQQomuHTdy
 wWgIp9BtzAQwzLAxiXBtXl07VZsjEODDFzxITnAt9JnPXI8ybZQ1GyvoYLB26rE1atxHOZA2z
 dKIHB5i9IANvwJrgwE79cc6RBdOrvbbzxRw/sPQeZZ96Mr3g3IYnjiWEvZc0eqmKln1wNUKHC
 dMRIVTtgnsllyrjESTy6ms3bLXh150dpetTWGamRv6aa6xNJEcEPnUlH8OdBk135xA/NKTBju
 C1VItJ6DSwqiJDIZUO9aDZkY16oRCdMYuoErBv23z1xc0hc9mwICqf6KFawbPVpR98NDybRhF
 4aMjJNXE7j11IKWW8KxlBuuqgB8Xba5FMLCd/HPrSUtZy2Sklo=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 9, 2020 at 6:02 AM Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> On 2020/6/9 上午12:41, Bjorn Helgaas wrote:
> > On Mon, Jun 08, 2020 at 10:54:15AM +0800, Zhangfei Gao wrote:
> >> On 2020/6/6 上午7:19, Bjorn Helgaas wrote:
> >>>> +++ b/drivers/iommu/iommu.c
> >>>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
> >>>> fwnode_handle *iommu_fwnode,
> >>>>           fwspec->iommu_fwnode = iommu_fwnode;
> >>>>           fwspec->ops = ops;
> >>>>           dev_iommu_fwspec_set(dev, fwspec);
> >>>> +
> >>>> +       if (dev_is_pci(dev))
> >>>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
> >>>> +
> >>>>
> >>>> Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
> >>>> Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
> >>>> Will send this when 5.8-rc1 is open.
> >>> Wait, this whole fixup approach seems wrong to me.  No matter how you
> >>> do the fixup, it's still a fixup, which means it requires ongoing
> >>> maintenance.  Surely we don't want to have to add the Vendor/Device ID
> >>> for every new AMBA device that comes along, do we?
> >>>
> >> Here the fake pci device has standard PCI cfg space, but physical
> >> implementation is base on AMBA
> >> They can provide pasid feature.
> >> However,
> >> 1, does not support tlp since they are not real pci devices.
> >> 2. does not support pri, instead support stall (provided by smmu)
> >> And stall is not a pci feature, so it is not described in struct pci_dev,
> >> but in struct iommu_fwspec.
> >> So we use this fixup to tell pci system that the devices can support stall,
> >> and hereby support pasid.
> > This did not answer my question.  Are you proposing that we update a
> > quirk every time a new AMBA device is released?  I don't think that
> > would be a good model.
>
> Yes, you are right, but we do not have any better idea yet.
> Currently we have three fake pci devices, which support stall and pasid.
> We have to let pci system know the device can support pasid, because of
> stall feature, though not support pri.
> Do you have any other ideas?

It sounds like the best way would be to allocate a PCI capability for it, so
detection can be done through config space, at least in future devices,
or possibly after a firmware update if the config space in your system
is controlled by firmware somewhere.  Once there is a proper mechanism
to do this, using fixups to detect the early devices that don't use that
should be uncontroversial. I have no idea what the process or timeline
is to add new capabilities into the PCIe specification, or if this one
would be acceptable to the PCI SIG at all.

If detection cannot be done through PCI config space, the next best
alternative is to pass auxiliary data through firmware. On DT based
machines, you can list non-hotpluggable PCIe devices and add custom
properties that could be read during device enumeration. I assume
ACPI has something similar, but I have not done that.

      Arnd
