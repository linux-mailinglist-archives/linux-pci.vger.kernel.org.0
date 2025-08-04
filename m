Return-Path: <linux-pci+bounces-33390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986FB1AA68
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 23:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DE3621981
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 21:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2FA22DA06;
	Mon,  4 Aug 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfS9Ge3a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0919C556;
	Mon,  4 Aug 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343570; cv=none; b=PLWuBo4kPY0ptwmUFnoaT5FGU0YgOmFxjCR+Tkup4OiLOqLQ2OljFpKsqZ6Wh+nyU/q39qZMKNQU2eSaFLh8OwDhQJxWb9DqzIZgvdYSI/LJ3TQYSvzwNdZBxDvbpcX6xJqpUb8xq2EedpnQiyTvvSuAxc6t3sjqBSo2gh46NaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343570; c=relaxed/simple;
	bh=/f1bD96WV3I4SoX2C4Usd4ZlmBzVIj6XnR6gondfk4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f45uHZ9EtnlNnYxeNVHYKxbDZDKfQsPNXQoQDal4Jd5nvnycpWA3LV8rp/lT7ReSpLZ8dDR7eACnlBEuQJFewHMOqoBRxbsz5i/Vb6gZ9oXOIy/zWlyvIND51QCNSWwrxDGYYc5M6joSHyXqDQlEJjdCdco8o5sCwuU98tBTk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfS9Ge3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E7C4CEE7;
	Mon,  4 Aug 2025 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754343570;
	bh=/f1bD96WV3I4SoX2C4Usd4ZlmBzVIj6XnR6gondfk4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TfS9Ge3ads3E2010Flnjgjfy7qEeNwRSuBBMiXd58GYIQte/6+NdNxjvlV5LfJhZJ
	 WDgeW9D4Mk7ovW6vRfYqFtTZRT/pXSts0Ap0WDzWSbjxNpqdh1EfyknD6oSkIWZMgU
	 isfpKCiTWINDtiLak/IOF7X/moxzmW5Yi2iFWeh9uwWZRyOsjgclHE/yQNYFjVMHpj
	 TSrHlMMiKU+NYxgnKzJm8a4j5GovvcCkJxTY3iaHMQhSXoLpxq6zg6N6xsyp01cM0I
	 LL4YX82Cwz/MjDd2q0QqjqoHZQRv7iYslvkvSl9LJhgdwRpKkcRAvykjvpkw/24JWo
	 wv1h4+b/oemCA==
Date: Mon, 4 Aug 2025 16:39:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 13/16] cxl/core, PCI: PCIe portdrv: Add CXL timeout range
 programming
Message-ID: <20250804213928.GA3643006@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730214718.10679-14-Benjamin.Cheatham@amd.com>

Drop a few of the subject line prefixes and mention something about
sysfs.  This has nothing to do with portdrv.  Following sibling "port
service drivers," I guess the prefix would be something like
"PCI/CXL:" or "PCI/CXL_ISO:"

On Wed, Jul 30, 2025 at 04:47:15PM -0500, Ben Cheatham wrote:
> Add functions to enable programming the CXL.mem transaction timeout
> range, if supported. Add a sysfs attribute to the "cxl_isolation" group
> to allow programming the timeout from userspace.

Include a sample path with at least the last 2-3 components.  Maybe
even an example, e.g.,

  # echo B2 > /sys/.../cxl_isolation/timeout_range

Probably also some doc in Documentation/ABI/testing/?

> The attribute can take either the CXL spec-defined hex value for the
> associated timeout range (CXL 3.2 8.2.4.24.2 field 3:0) or a
> string with the range. The range string is formatted as the range letter
> in uppercase or lowercase, with an optional "2" to specify the second
> range in the aforementioned spec ref.
> 
> For example, to program the port with a timeout of 65ms to 210ms (range B)
> the following strings could be specified: "b2"/"B2". Picking the first
> portion of range B (16ms to 55ms) would be: "b"/"B".

What's the value of accepting either upper- or lower-case?  It doubles
the size of ranges[], and I think timeout_range_show() always shows
the lower-case one.  The spec uses upper-case.

> +/* CXL 3.2 8.2.4.24.2 CXL Timeout & Isolation Control Register, field 3:0 */
> +const struct timeout_ranges {
> +	char *str;
> +	u8 val;
> +} ranges[] = {
> +	{ .str = "a", .val = 0x1 },
> +	{ .str = "A", .val = 0x1 },
> +	{ .str = "a2", .val = 0x2 },
> +	{ .str = "A2", .val = 0x2 },
> +	{ .str = "b", .val = 0x5 },
> +	{ .str = "B", .val = 0x5 },
> +	{ .str = "b2", .val = 0x6 },
> +	{ .str = "B2", .val = 0x6 },
> +	{ .str = "c", .val = 0x9 },
> +	{ .str = "C", .val = 0x9 },
> +	{ .str = "c2", .val = 0xA },
> +	{ .str = "C2", .val = 0xA },
> +	{ .str = "d", .val = 0xD },
> +	{ .str = "D", .val = 0xD },
> +	{ .str = "d2", .val = 0xE },
> +	{ .str = "D2", .val = 0xE },
> +};
> +
> +static int timeout_range_str_to_val(const char *str, u8 *val)
> +{
> +	char val_buf[32] = { 0 };
> +	char *start;
> +
> +	strscpy(val_buf, str, ARRAY_SIZE(val_buf) - 1);
> +	start = strim(val_buf);
> +	if (!start)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < ARRAY_SIZE(ranges); i++)
> +		if (strcmp(start, ranges[i].str) == 0)
> +			return ranges[i].val;
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t timeout_range_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port;
> +	u8 val;
> +	int rc;
> +
> +	rc = kstrtou8(buf, 0, &val);
> +	if (rc && timeout_range_str_to_val(buf, &val) < 0)
> +		return -EINVAL;
> +
> +	struct cxl_dport **dport __free(kfree) =
> +		kzalloc(sizeof(*dport), GFP_KERNEL);
> +	if (!dport)
> +		return -ENOMEM;
> +
> +	port = cxl_find_pcie_rp(pdev, dport);
> +	if (!port || !(*dport))
> +		return -ENODEV;
> +
> +	if (!(*dport)->regs.isolation)
> +		return -ENXIO;
> +
> +	rc = cxl_set_timeout_range(*dport, val);
> +	put_device(&port->dev);
> +	return rc ? rc : n;
> +}
> +
> +static ssize_t timeout_range_show(struct device *dev,
> +				  struct device_attribute *attr, char * buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port;
> +	u32 ctrl, val;
> +
> +	struct cxl_dport **dport __free(kfree) =
> +		kzalloc(sizeof(*dport), GFP_KERNEL);
> +	if (!dport)
> +		return -ENOMEM;
> +
> +	port = cxl_find_pcie_rp(pdev, dport);
> +	if (!port || !(*dport))
> +		return -ENODEV;
> +
> +	if (!(*dport)->regs.isolation)
> +		return -ENXIO;
> +
> +	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
> +	put_device(&port->dev);
> +
> +	val = FIELD_GET(CXL_ISOLATION_CTRL_MEM_TIME_MASK, ctrl);
> +	for (int i = 0; i < ARRAY_SIZE(ranges); i++)
> +		if (ranges[i].val == val)
> +			return sysfs_emit(buf, "%s\n", ranges[i].str);
> +
> +	return -ENXIO;
> +}
> +DEVICE_ATTR_RW(timeout_range);
> +
>  static struct attribute *isolation_attrs[] = {
>  	&dev_attr_timeout_ctrl.attr,
>  	&dev_attr_isolation_ctrl.attr,
> +	&dev_attr_timeout_range.attr,
>  	NULL,
>  };
>  
> diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
> index 0b6e4f0160a8..f2c4feb5a42b 100644
> --- a/include/cxl/isolation.h
> +++ b/include/cxl/isolation.h
> @@ -30,6 +30,7 @@ void cxl_enable_isolation(struct cxl_dport *dport);
>  int cxl_disable_isolation(struct cxl_dport *dport);
>  void cxl_enable_timeout(struct cxl_dport *dport);
>  void cxl_disable_timeout(struct cxl_dport *dport);
> +int cxl_set_timeout_range(struct cxl_dport *dport, u8 val);
>  
>  struct cxl_port *cxl_find_pcie_rp(struct pci_dev *pdev,
>  				  struct cxl_dport **dport);
> @@ -39,6 +40,8 @@ static inline int cxl_disable_isolation(struct cxl_dport *dport)
>  { return -ENXIO; }
>  static inline void cxl_enable_timeout(struct cxl_dport *dport) {}
>  static inline void cxl_disable_timeout(struct cxl_dport *dport) {}
> +static inline int cxl_set_timeout_range(struct cxl_dport *dport, u8 val)
> +{ return -ENXIO; }
>  
>  static inline struct cxl_port *cxl_find_pcie_rp(struct pci_dev *pdev,
>  						struct cxl_dport **dport);
> -- 
> 2.34.1
> 

