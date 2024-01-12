Return-Path: <linux-pci+bounces-2075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B982B99D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 03:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B30284D1D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE38654;
	Fri, 12 Jan 2024 02:35:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A5136B;
	Fri, 12 Jan 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.122])
	by gateway (Coremail) with SMTP id _____8BxHOtapaBlOG4EAA--.13142S3;
	Fri, 12 Jan 2024 10:35:06 +0800 (CST)
Received: from [10.20.42.122] (unknown [10.20.42.122])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axz99UpaBl5ZISAA--.48437S3;
	Fri, 12 Jan 2024 10:35:06 +0800 (CST)
Message-ID: <2a5e3801-6740-0c63-6819-83a18f552dbf@loongson.cn>
Date: Fri, 12 Jan 2024 10:35:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] PCI: Fix kernel-doc issues
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240111162850.2177655-1-helgaas@kernel.org>
Content-Language: en-US
From: Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20240111162850.2177655-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Axz99UpaBl5ZISAA--.48437S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw4UKFWDJFWUtr18tFy7urX_yoWxKwc_A3
	y3J3yUGrs7Aw4UAr4rCa9rXF4Y93y0qF9Fqw4rXrZxWFn0kw4Yya97JFyqkF45G3s2kF1Y
	kFykC3Zaqrn0vosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
	UUU==

Hi,


On 2024/1/12 00:28, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix kernel-doc issues reported by
> "find include -name \*pci\* | xargs scripts/kernel-doc -none":
>
>    include/linux/pci.h:731: warning: Function parameter or member 'pdev' not described in 'pci_is_vga'
>    include/linux/pci-epc.h:154: warning: Function parameter or member 'list_lock' not described in 'pci_epc'
>    include/linux/pci-epf.h:83: warning: expecting prototype for struct pci_epf_event_ops. Prototype was for struct pci_epc_event_ops instead


Thanks a lot for the fix.


> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


Acked-by: Sui Jingfeng <suijingfeng@loongson.cn>


