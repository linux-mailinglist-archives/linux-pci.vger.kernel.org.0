Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFC22A18A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 23:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGVVvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 17:51:04 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:13680 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgGVVvE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 17:51:04 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MLmUpp000634;
        Wed, 22 Jul 2020 21:50:51 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 32dv36qj3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 21:50:51 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 09B3C76;
        Wed, 22 Jul 2020 21:50:50 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.33.237.3])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 5C2594A;
        Wed, 22 Jul 2020 21:50:48 +0000 (UTC)
Date:   Wed, 22 Jul 2020 15:50:48 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>, jroedel@suse.de,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>,
        Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200722215048.GL220876@anatevka.americas.hpqcorp.net>
References: <CACPcB9cpEX-uYeTp7DVEXtwDRWBCTVoPCB4dxPbyq1sDeixP_w@mail.gmail.com>
 <20200722152123.GA1278089@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722152123.GA1278089@bjorn-Precision-5520>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_16:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=1 mlxscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007220136
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 10:21:23AM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 22, 2020 at 10:52:26PM +0800, Kairui Song wrote:
> > On Fri, Mar 6, 2020 at 5:38 PM Baoquan He <bhe@redhat.com> wrote:
> > > On 03/04/20 at 08:53pm, Deepa Dinamani wrote:
> > > > On Wed, Mar 4, 2020 at 7:53 PM Baoquan He <bhe@redhat.com> wrote:
> > > > > On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> > > > > > I looked at this some more. Looks like we do not clear irqs
> > > > > > when we do a kexec reboot. And, the bootup code maintains
> > > > > > the same table for the kexec-ed kernel. I'm looking at the
> > > > > > following code in
> > > > >
> > > > > I guess you are talking about kdump reboot here, right? Kexec
> > > > > and kdump boot take the similar mechanism, but differ a
> > > > > little.
> > > >
> > > > Right I meant kdump kernel here. And, clearly the
> > > > is_kdump_kernel() case below.
> > > >
> > > > > > intel_irq_remapping.c:
> > > > > >
> > > > > >         if (ir_pre_enabled(iommu)) {
> > > > > >                 if (!is_kdump_kernel()) {
> > > > > >                         pr_warn("IRQ remapping was enabled on %s but
> > > > > > we are not in kdump mode\n",
> > > > > >                                 iommu->name);
> > > > > >                         clear_ir_pre_enabled(iommu);
> > > > > >                         iommu_disable_irq_remapping(iommu);
> > > > > >                 } else if (iommu_load_old_irte(iommu))
> > > > >
> > > > > Here, it's for kdump kernel to copy old ir table from 1st kernel.
> > > >
> > > > Correct.
> > > >
> > > > > >                         pr_err("Failed to copy IR table for %s from
> > > > > > previous kernel\n",
> > > > > >                                iommu->name);
> > > > > >                 else
> > > > > >                         pr_info("Copied IR table for %s from previous kernel\n",
> > > > > >                                 iommu->name);
> > > > > >         }
> > > > > >
> > > > > > Would cleaning the interrupts(like in the non kdump path
> > > > > > above) just before shutdown help here? This should clear the
> > > > > > interrupts enabled for all the devices in the current
> > > > > > kernel. So when kdump kernel starts, it starts clean. This
> > > > > > should probably help block out the interrupts from a device
> > > > > > that does not have a driver.
> > > > >
> > > > > I think stopping those devices out of control from continue
> > > > > sending interrupts is a good idea. While not sure if only
> > > > > clearing the interrupt will be enough. Those devices which
> > > > > will be initialized by their driver will brake, but devices
> > > > > which drivers are not loaded into kdump kernel may continue
> > > > > acting. Even though interrupts are cleaning at this time, the
> > > > > on-flight DMA could continue triggerring interrupt since the
> > > > > ir table and iopage table are rebuilt.
> > > >
> > > > This should be handled by the IOMMU, right? And, hence you are
> > > > getting UR. This seems like the correct execution flow to me.
> > >
> > > Sorry for late reply.
> > > Yes, this is initializing IOMMU device.
> > >
> > > > Anyway, you could just test this theory by removing the
> > > > is_kdump_kernel() check above and see if it solves your problem.
> > > > Obviously, check the VT-d spec to figure out the exact sequence to
> > > > turn off the IR.
> > >
> > > OK, I will talk to Kairui and get a machine to test it. Thanks for your
> > > nice idea, if you have a draft patch, we are happy to test it.
> > >
> > > > Note that the device that is causing the problem here is a legit
> > > > device. We want to have interrupts from devices we don't know about
> > > > blocked anyway because we can have compromised firmware/ devices that
> > > > could cause a DoS attack. So blocking the unwanted interrupts seems
> > > > like the right thing to do here.
> > >
> > > Kairui said it's a device which driver is not loaded in kdump kernel
> > > because it's not needed by kdump. We try to only load kernel modules
> > > which are needed, e.g one device is the dump target, its driver has to
> > > be loaded in. In this case, the device is more like a out of control
> > > device to kdump kernel.
> > 
> > Hi Bao, Deepa, sorry for this very late response. The test machine was
> > not available for sometime, and I restarted to work on this problem.
> > 
> > For the workaround mention by Deepa (by remote the is_kdump_kernel()
> > check), it didn't work, the machine still hangs upon shutdown.
> > The devices that were left in an unknown state and sending interrupt
> > could be a problem, but it's irrelevant to this hanging problem.
> > 
> > I think I didn't make one thing clear, The PCI UR error never arrives
> > in kernel, it's the iLo BMC on that HPE machine caught the error, and
> > send kernel an NMI. kernel is panicked by NMI, I'm still trying to
> > figure out why the NMI hanged kernel, even with panic=-1,
> > panic_on_io_nmi, panic_on_unknown_nmi all set. But if we can avoid the
> > NMI by shutdown the devices in right order, that's also a solution.
> 
> I'm not sure how much sympathy to have for this situation.  A PCIe UR
> is fatal for the transaction and maybe even the device, but from the
> overall system point of view, it *should* be a recoverable error and
> we shouldn't panic.
> 
> Errors like that should be reported via the normal AER or ACPI/APEI
> mechanisms.  It sounds like in this case, the platform has decided
> these aren't enough and it is trying to force a reboot?  If this is
> "special" platform behavior, I'm not sure how much we need to cater
> for it.
> 

Are these AER errors the type processed by the GHES code?

I'll note that RedHat runs their crash kernel with:  hest_disable.
So, the ghes code is disabled in the crash kernel.


-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
