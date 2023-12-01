Return-Path: <linux-pci+bounces-311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6180012D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 02:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B772B20DD1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224A515B2;
	Fri,  1 Dec 2023 01:41:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D6810F8;
	Thu, 30 Nov 2023 17:41:51 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id AEF8624E257;
	Fri,  1 Dec 2023 09:41:29 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 09:41:29 +0800
Received: from [192.168.125.136] (113.72.145.176) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 09:41:28 +0800
Message-ID: <95ec1fa5-1ab1-439f-96db-0ae2989915ce@starfivetech.com>
Date: Fri, 1 Dec 2023 09:41:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mason.huo@starfivetech.com>,
	<leyfoon.tan@starfivetech.com>, <minda.chen@starfivetech.com>
References: <20231130183504.GA487377@bhelgaas>
From: Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20231130183504.GA487377@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable



On 2023/12/1 2:35, Bjorn Helgaas wrote:
> On Thu, Nov 30, 2023 at 06:03:55PM +0800, Kevin Xie wrote:
>> On 2023/11/30 7:21, Bjorn Helgaas wrote:
>> > On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
>> >> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum wai=
ting
>> >> time between sending the first configuration request to the device =
and
>> >> exit from a conventional reset (or after link training completes).
>> >=20
>> > s/marco/macro/
>> >=20
>> > List the first event before the second one, i.e., the delay is from
>> > exit from reset to the config request.
>>=20
>> OK=EF=BC=8CI will use "from A to B" instead of "between A and B".
>=20
> That's not my point.
>=20
> My point was you said "between B (config request) and A (exit from
> reset)".  "A" happens first, so it should be mentioned first.
>=20

Got it.

>> > I assume there are follow-on patches that actually use this?  Can we
>> > make this the first patch in a series so we know we don't have an
>> > unused macro lying around?
>>=20
>> Yes, we will use the marco in the next version of our PCIe controller =
patches.
>> Here is the link of current version patch series:
>> https://lore.kernel.org/lkml/20231115114912.71448-20-minda.chen@starfi=
vetech.com/T/#u=20
>>=20
>> Do you mean that I should put this patch back to the above series as
>> one of the separate patches?
>=20
> Yes, please.  Handling them as a group is less overhead and helps
> avoid merge issues (if they're all in a series there's no possibility
> that the user gets merged before the macro itself).
>=20

OK, I will put the patch back with these changes.

> Bjorn

