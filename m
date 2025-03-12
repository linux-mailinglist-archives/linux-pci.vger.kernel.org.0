Return-Path: <linux-pci+bounces-23490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F36A5DA32
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37A1189DAD4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1F23DE80;
	Wed, 12 Mar 2025 10:10:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0423C8C3;
	Wed, 12 Mar 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774213; cv=none; b=AdSG37TZ3y2HIDqv1RK0jjQVriEiiAZdC/9XBXLj6HLsWOv+Lr5kMN04u3/jVu5nhpWsMVOScKQUY5UArZGIG6xTsP/3MNfUQc56q5Ln3d3q8yzcR/gZHCSEn3qLHphU/HozfOobyqfNgB+Wt32QiN3C0IULZaKhr5h4Nh71nIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774213; c=relaxed/simple;
	bh=/8ncitlyunX6JU7zE0YnHRfHzTzK/FruopaJkPi/R/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxnSIh7pau6QGwDKZ4SyVK2ybB8sq2MS5Hj3BU8qF7MlSagnrrPmn3Bj1+qQTPyYQVYJpEUnhOQhsmy3yhoXGGa/sYfTUTVb1f9cprXFH9h2LHe34CjnRb5v4EVbSVnib8KuMhIy4eB0FuetiifU0n2GPh4g+GwQWdSB9AKuuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CE0152B;
	Wed, 12 Mar 2025 03:10:22 -0700 (PDT)
Received: from [10.57.38.75] (unknown [10.57.38.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 734303F5A1;
	Wed, 12 Mar 2025 03:10:06 -0700 (PDT)
Message-ID: <d55240a4-fe4a-48ea-b3a8-9a997bb7267c@arm.com>
Date: Wed, 12 Mar 2025 10:10:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Joerg Roedel <joro@8bytes.org>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z9CEIlXoQJ-A0t-d@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z9CEIlXoQJ-A0t-d@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-11 6:42 pm, Joerg Roedel wrote:
> Hi Robin,
> 
> On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
>> +	/*
>> +	 * And if we do now see any replay calls, they would indicate someone
>> +	 * misusing the dma_configure path outside bus code.
>> +	 */
>> +	if (dev->driver)
>> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
> 
> This warning triggers on my workstation (with an AMD IOMMU), any ideas?

Argh! When I moved the dma_configure call into iommu_init_device() for
v2 I moved the warning with it, but of course that needs to stay where
it was, *after* the point that ops->probe_device has had a chance to
filter out irrelevant devices. Does this make it behave?

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 09798ddbce9d..1da6c55a0d02 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -437,12 +437,6 @@ static int iommu_init_device(struct device *dev)
  		ret = -ENODEV;
  		goto err_free;
  	}
-	/*
-	 * And if we do now see any replay calls, they would indicate someone
-	 * misusing the dma_configure path outside bus code.
-	 */
-	if (dev->driver)
-		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
  
  	if (!try_module_get(ops->owner)) {
  		ret = -EINVAL;
@@ -565,6 +559,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
  	ret = iommu_init_device(dev);
  	if (ret)
  		return ret;
+	/*
+	 * And if we do now see any replay calls, they would indicate someone
+	 * misusing the dma_configure path outside bus code.
+	 */
+	if (dev->driver)
+		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
  
  	group = dev->iommu_group;
  	gdev = iommu_group_alloc_device(group, dev);


