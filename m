Return-Path: <linux-pci+bounces-928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793781258A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 03:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23FBB20F3E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173B81E;
	Thu, 14 Dec 2023 02:54:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A14BD
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 18:54:39 -0800 (PST)
X-ASG-Debug-ID: 1702522474-086e236fee3a910001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id VuPZGLG02fCavwkv (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 14 Dec 2023 10:54:34 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Dec
 2023 10:54:33 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Dec
 2023 10:54:31 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <2d93da18-c5a9-4cd5-a912-d4751f492682@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date: Thu, 14 Dec 2023 10:54:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
To: Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <CobeChen@zhaoxin.com>,
	<TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>, <LeoLiu@zhaoxin.com>
References: <20231206230840.GA733691@bhelgaas>
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20231206230840.GA733691@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1702522474
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1133
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118057
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



在 2023/12/7 7:08, Bjorn Helgaas 写道:
> On Wed, Nov 15, 2023 at 05:16:12PM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> Call the func pci_acpi_program_hest_aer_params() for every PCIe device.
>> Extracting register value from HEST PCIe AER structures and programming
>> them into AER Capabilities are implemented in this function.
>> The implementation of the function is an effective supplement to _HPP/_HPX
>> method when the Firmware does not support the _HPP/_HPX method and can be
>> specially configured for the AER register of the specific device.
> 
> Rewrap into a single paragraph or add blank lines between.
> 
> If this is needed to make some machine work correctly, please include
> that information here.
> 
> Based on Rafael's comment about getting the actbl1.h change merged via
> ACPICA first, I assume this entire series is will wait for that ACPICA
> update.
> 
> Bjorn

As mentioned in email " RE [PATCH 1/3] ACPI/APEI: Add 
hest_parse_pcie_aer()" , In the next version, I will move this data 
structure to another file.

Yours sincerely,
Leoliu-oc

