Return-Path: <linux-pci+bounces-19238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E612A00C15
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BF81642E0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532CC1FBCBA;
	Fri,  3 Jan 2025 16:32:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF00BE4F;
	Fri,  3 Jan 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921961; cv=none; b=fqPg1Og3ZBIb0s6znHqC/tT9IYN4whjxbSUkAOuP2jdFsXnHk8CsJNbyR6Jg8K1nKzsm9Uf69ko8cPFpQHsvjPTBYYfPPL+AJAiNu3376OC1Z0MiMPKOqMxdbxOf//WIQfTSbKkG6m+CW2x7Paj7xIN+XNt4MxXCyea9WcYSVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921961; c=relaxed/simple;
	bh=wjjCayMRxpUrNQOT2ItnVP74lZ1UN1qFUL+nh8cNcCk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnCX3eKjuEcL5PPDW5Lo2+ZDoQ2sUjMkk+2JqKLWQj4IvWZI9//lXb33rWr6b4a+xevPTShFpd5l6tM+HuGZyQAX5qZPiQWkvSeVYj2PyKLcXs5lIYzyM0QE31Fl6MBQ+80M4Kxs8v/FwnpXxgvd1S5RzvCatkUf2gsA4ytsDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPpsT6k8Kz6K61T;
	Sat,  4 Jan 2025 00:28:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E92261402DB;
	Sat,  4 Jan 2025 00:32:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 17:32:35 +0100
Date: Fri, 3 Jan 2025 16:32:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Atharva Tiwari <evepolonium@gmail.com>
CC: <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<mahesh@linux.ibm.com>, <oohall@gmail.com>
Subject: Re: [PATCH] PCI/AER:Add error message when unable to handle
 additional devices
Message-ID: <20250103163233.00006683@huawei.com>
In-Reply-To: <20250103132035.1653-1-evepolonium@gmail.com>
References: <20241227071910.1719-1-evepolonium@gmail.com>
	<20250103132035.1653-1-evepolonium@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri,  3 Jan 2025 18:50:35 +0530
Atharva Tiwari <evepolonium@gmail.com> wrote:

> i completed the todo on line 886 thats why
> 

It is a question, not a todo.  So if you wish to
make the change you need to discuss why the answer to that
question was 'yes it makes sense to print an error message here'.

Jonathan

