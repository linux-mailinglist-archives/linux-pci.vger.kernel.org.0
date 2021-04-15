Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B436033E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhDOHZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 03:25:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14566 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231280AbhDOHZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 03:25:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F73hkK136923;
        Thu, 15 Apr 2021 03:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=q9T8SahEZUqDVixHepan04p7Sk4pDUeFxzkOwHaURFg=;
 b=dlZeaupqjVIc5GSpHSE+gdpu7tsZANMiW38zVzpg/8NUEJlCT3oNl6I7OzXruGdYDGjT
 CSoFTle7AsQznYRJca4p19MS3Fh3BxxIR0uQ09eU7KGRObWJZjBCkeweVE1LrnGGKbTj
 5DFcuLBiN3BZf8e16o4vSgZxrszn+TpidTpU9ZZR/fDXblsitHN5WSWUrvS4fRCJQHhN
 E3UgU1oKzCu4mpIQMb+02qkfYXgSj5Ns+H4SyrV8yUdPXRmR1rE0eDR97yL73ZurSkpI
 VNH3yTuxYnLnK1CUPqaw/CMqgy1uNBEijPZF+W/lGs4OTBdqjed227c4c07qHpGN115Q YA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x88hu7df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:24:42 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13F77RnN023783;
        Thu, 15 Apr 2021 07:24:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n8bq4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 07:24:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13F7OXWh66060664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 07:24:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D397AAE055;
        Thu, 15 Apr 2021 07:24:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58A46AE045;
        Thu, 15 Apr 2021 07:24:33 +0000 (GMT)
Received: from sig-9-145-170-145.de.ibm.com (unknown [9.145.170.145])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Apr 2021 07:24:33 +0000 (GMT)
Message-ID: <bd95605ed435ad3978535d865b883f58c1d542d6.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Narendra K <narendra_k@dell.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date:   Thu, 15 Apr 2021 09:24:33 +0200
In-Reply-To: <20210414201755.GA2532433@bjorn-Precision-5520>
References: <20210414201755.GA2532433@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bRJFPuNoMNuWoQLkOpRZm60i16bhhTiI
X-Proofpoint-ORIG-GUID: bRJFPuNoMNuWoQLkOpRZm60i16bhhTiI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150046
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-04-14 at 15:17 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 12, 2021 at 03:59:05PM +0200, Niklas Schnelle wrote:
> > On s390 each PCI device has a user-defined ID (UID) exposed under
> > /sys/bus/pci/devices/<dev>/uid. This ID was designed to serve as the PCI
> > device's primary index and to match the device within Linux to the
> > device configured in the hypervisor. To serve as a primary identifier
> > the UID must be unique within the Linux instance, this is guaranteed by
> > the platform if and only if the UID Uniqueness Checking flag is set
> > within the CLP List PCI Functions response.
> > 
> > In this sense the UID serves an analogous function as the SMBIOS
> > instance number or ACPI index exposed as the "index" respectively
> > "acpi_index" device attributes and used by e.g. systemd to set interface
> > names. As s390 does not use and will likely never use ACPI nor SMBIOS
> > there is no conflict and we can just expose the UID under the "index"
> > attribute whenever UID Uniqueness Checking is active and get systemd's
> > interface naming support for free.
> > 
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Acked-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
> 
> This seems like a nice solution to me.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks! Yes I agree it's a simple solution that also makes sense from a
design point. I'll wait for Narendra's opinion of course.

> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci | 11 +++++---
> >  arch/s390/pci/pci_sysfs.c               | 35 +++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 25c9c39770c6..1241b6d11a52 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -195,10 +195,13 @@ What:		/sys/bus/pci/devices/.../index
> >  Date:		July 2010
> >  Contact:	Narendra K <narendra_k@dell.com>, linux-bugs@dell.com
> >  Description:
> > -		Reading this attribute will provide the firmware
> > -		given instance (SMBIOS type 41 device type instance) of the
> > -		PCI device. The attribute will be created only if the firmware
> > -		has given an instance number to the PCI device.
> > +		Reading this attribute will provide the firmware given instance
> > +		number of the PCI device.  Depending on the platform this can
> > +		be for example the SMBIOS type 41 device type instance or the
> > +		user-defined ID (UID) on s390. The attribute will be created
> > +		only if the firmware has given an instance number to the PCI
> > +		device and that number is guaranteed to uniquely identify the
> > +		device in the system.
> >  Users:
> >  		Userspace applications interested in knowing the
> >  		firmware assigned device type instance of the PCI
> > diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> > index e14d346dafd6..20dbb2058d51 100644
> > --- a/arch/s390/pci/pci_sysfs.c
> > +++ b/arch/s390/pci/pci_sysfs.c
> > @@ -138,6 +138,38 @@ static ssize_t uid_is_unique_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(uid_is_unique);
> >  
> > +#ifndef CONFIG_DMI
> > +/* analogous to smbios index */
> 
> I think this is smbios_attr_instance, right?  Maybe mention that
> specifically to make it easier to match these up.
> 
> Looks like smbios_attr_instance and the similar ACPI stuff could use
> some updating to use the current attribute group infrastructure.
> 
> > +static ssize_t index_show(struct device *dev,
> > +			  struct device_attribute *attr, char *buf)
> > +{
> > +	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
> > +	u32 index = ~0;
> > +
> > +	if (zpci_unique_uid)
> > +		index = zdev->uid;
> > +
> > +	return sysfs_emit(buf, "%u\n", index);
> > +}
> > +static DEVICE_ATTR_RO(index);
> > +
> > +static umode_t zpci_unique_uids(struct kobject *kobj,
> > +				struct attribute *attr, int n)
> > +{
> > +	return zpci_unique_uid ? attr->mode : 0;
> > +}
> > +
> > +static struct attribute *zpci_ident_attrs[] = {
> > +	&dev_attr_index.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group zpci_ident_attr_group = {
> > +	.attrs = zpci_ident_attrs,
> > +	.is_visible = zpci_unique_uids,
> 
> It's conventional to name these functions *_is_visible() (another
> convention that smbios_attr_instance and acpi_attr_index probably
> predate).

Thanks, will change. Since he function then references the attribtue
instead of the condition, I'll go with zpci_index_is_visible().

> 
> > +};
> > +#endif
> > +
> >  static struct bin_attribute *zpci_bin_attrs[] = {
> >  	&bin_attr_util_string,
> >  	&bin_attr_report_error,
> > @@ -179,5 +211,8 @@ static struct attribute_group pfip_attr_group = {
> >  const struct attribute_group *zpci_attr_groups[] = {
> >  	&zpci_attr_group,
> >  	&pfip_attr_group,
> > +#ifndef CONFIG_DMI
> > +	&zpci_ident_attr_group,
> > +#endif
> >  	NULL,
> >  };
> > -- 
> > 2.25.1
> > 

