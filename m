Return-Path: <linux-pci+bounces-21490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D85A36432
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94AE16BF9C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3969267AE8;
	Fri, 14 Feb 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NpCRNeJh"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DEF264FA7;
	Fri, 14 Feb 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553324; cv=none; b=JO8zMpnlLuz9Zkdu7BnAWpCcTkjpRKn9Ny+2YAZq6rTDj4iXMISWHgezFBI0XNs6osNA1IxguEyX3LfuoM9hWP9a1fUudk309hIBwg4ApeE3eAkB0/PmTsBxjz60HnN2uoopvfsHvAJhsFi8hAykLYS3SYsE6NHCCG0GV1/8XM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553324; c=relaxed/simple;
	bh=S9WjGdtvIsKjAKlR5pneH7fuX8o345hhaDrE5r31kEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otNG+6GwZEKvN0EFP3uGBDWHrKnyfyI9dgPgUus+TvxL+olMR2l2dRTkAmlLdqqNt7igE1bwaU6Wa2jAFFrRZgEIPs6jg4HVfwwLJN2hSmkbcVNQuMAQDpA9Uond4QvSTj6XIAaV9pGBGKgRU8A6nbwOx7mVTsq/z2xUPNxJdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NpCRNeJh; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=6xVWvRhjTlWlZPqpm5zHdVjRt4ZMc7xvv3s8Ld26ZSU=;
	b=NpCRNeJhvJwkJiV1YwZpxHSkVeka7upYQJnPXJ56loqa0ma8rMGb0G/vQMWBx7
	H3cbl1CdSySstuqk39bVFDlKYhbav19Xq0SMscHza+szrAnNCCko1eQRNo3iTOyM
	QRG7GQDcdE3UHjfe90TB+YZs0ZSzq4eRXiNGYDqpz75jk=
Received: from [192.168.71.44] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXUe73ea9nN+QYCg--.1355S2;
	Sat, 15 Feb 2025 01:14:32 +0800 (CST)
Message-ID: <283c5233-942d-45a5-9527-b9abc29eaa29@163.com>
Date: Sat, 15 Feb 2025 01:14:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, jingoohan1@gmail.com,
 shradha.t@samsung.com, manivannan.sadhasivam@linaro.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 Frank.Li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 rockswang7@gmail.com
References: <20250214170556.GA156582@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250214170556.GA156582@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgDXUe73ea9nN+QYCg--.1355S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcMa0UUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwvzo2evdvUsBwAAs0



On 2025/2/15 01:05, Bjorn Helgaas wrote:
> On Fri, Feb 14, 2025 at 04:34:29PM +0800, Hans Zhang wrote:
>> I will git pull the latest code and fix it.
> 
> The general rule is to base on -rc1 (a.k.a. the pci/main branch), or
> on top of a topic branch if the patch depends on something already
> queued on that branch (and mention the branch if this is the case).

I haven't updated the base code for a while, which is causing conflicts, 
and I've committed version v3.

Thanks Bjorn for reminding me.

Best regards
Hans


