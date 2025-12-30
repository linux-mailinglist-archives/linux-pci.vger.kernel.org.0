Return-Path: <linux-pci+bounces-43824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F5CE8A63
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 04:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40BA63010CE4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 03:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FB2367A2;
	Tue, 30 Dec 2025 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="R3wdk7KE"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0163EEA8;
	Tue, 30 Dec 2025 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767066040; cv=none; b=Pmmbuooziel62+VWdLnKU/L5yGRri3cpf5WPhWQRNLX/zUsOgHDwri1tjxOdABFYXFQVPIMrxz3aATVYgK9yvkF08zxQc5KBMPw6CZBB7R6xblk9S1RBJof+y0L9SXGSb0/HnhxgSNHEng7NBdo5xhk3RAOFNeHJIAc73pjbaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767066040; c=relaxed/simple;
	bh=ltT+vszn8kSTdvlD0geBnq7r4kSJNdeCA/R09j3RlmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UH5xVhjQy1gZoYrSrC1NNCjdjYFLZf8QIwqmsqrsznThRB/0A7BIwf8eezDeDu/8L0DFQisMZ6xydb0yjLNS3EZGH7ZMluCmm6pOFAxVEPKntHjM1xthTStAzdwVmFZmrbqKKmH42I2LuP/Yf/RSymCGdJuNe3x0OfrYgpTVzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=R3wdk7KE; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NyQ26FCINybdvkM81YY13ZZndejxEkTGyzHk/5MvkyY=;
	b=R3wdk7KEGSIVP/kFZMY2uDeFFKvKjbEAVkiYYCK4Ik2OFrqe/utHqqZA+LT1OtRGk5S7xzGBb
	BgXR4bajGrbBSWD6b7gXVt9Q2wCvfeYAH37+jui3eNCjG30RA1lTSzBuTI3XE/xS1mUSkMdVvlp
	y4fgz7QwT2C0SZTh+NTEFj0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dgJgL1Hf8zLlVF;
	Tue, 30 Dec 2025 11:37:18 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id EA8954056B;
	Tue, 30 Dec 2025 11:40:27 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 11:40:27 +0800
Message-ID: <73f351b9-5355-4111-9d29-9b3b906cb651@huawei.com>
Date: Tue, 30 Dec 2025 11:40:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI/sysfs: Fix null pointer dereference during
 hotplug
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>, <chrisw@redhat.com>,
	<alex.williamson@redhat.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>
References: <20251229173106.GA69373@bhelgaas>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20251229173106.GA69373@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2025/12/30 1:31, Bjorn Helgaas 写道:
> On Wed, Dec 24, 2025 at 05:27:17PM +0800, Ziming Du wrote:
>> During the concurrent process of creating and rescanning in VF, the
>> resource files for the same pci_dev may be created twice. The second
>> creation attempt fails, resulting the res_attr in pci_dev to kfree(),
>> but the pointer is not set to NULL. This will subsequently lead to
>> dereferencing a null pointer when removing the device.
>>
>> When we perform the following operation:
>>    echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &
> Is the value of $vfcount relevant here?  Can you use the actual values
> here instead of the variables so this is more useful to others?

In fact, we directly use sriov_totalvfs here. In my opinion, the larger 
this value is,

the more likely it is to cause the issue.

>>    sleep 0.5
>>    echo 1 > /sys/bus/pci/rescan
>>    pci_remove "$pfname"
>> system will crash as follows:

