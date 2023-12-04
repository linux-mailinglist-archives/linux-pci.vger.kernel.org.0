Return-Path: <linux-pci+bounces-433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C5803AC3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735E5281438
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877D2511D;
	Mon,  4 Dec 2023 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rVzgEuGM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E2B4;
	Mon,  4 Dec 2023 08:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVLmmvvzn5/tRDOJD7VIJTby4Qd5ngW7CTpTyZJKq4IlGaD6AxgfIGPUs+Jc1Bu8UIKdAZTbqBWwyAKWw+VH067Z8Y2N9xIlMJynbNN9jqbjrAnVmAplNkIqAB9L4nymc2B7TqXaU481TkQKf3eA60AopUf9TNlWa5m10qqjx1SAltU7DeobrYsRiKXKEpaBXyPON7V8zPxOr1RdRnA80mFCXZMNmiHLjhUJ6VNfqc3ZcqMUj/zJjYNg5qrdCw3sJBTRLeENnx5YWHmvveIuVzJk7Q+jvvjOby0AhORQAK/zV+DMuBZOgt2u0c6gf+DRPGUJZFb9ffcl7YS7lpw6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxvuhFGyYcnEFbCPgvDB1H7cn79rwkKs54U5nhXao9s=;
 b=P2k0PEe0Q38s0+OkyCjI9nevMdqWdwGA7S1CrYI7WgPHBFuATMbHSxBRztWuaVBnqDgJ8TLO7cePDuw2JrF4DNHeNDlT9lOgOx+PCT5oqUXthg6I+Q4liVWo/vQ95thkLGO9jJkkuCg6VjgMqEOKMpZxh9sJemk9w7iCApp2WJ5In1DGHfFHZUeaSMIugBrPHGH1nGiJ4yIewn2drWYqNmOxStlpZDSbQHKYlbJa/CfNouShwmpYN76yJCHlplcWFmF3W6hngSdnqkt7Vd8L+siIU+7ZLqM/Ws64K7JEy+yjPi+6ALi0BtJf7KYD32PEudhdbdwQycVCGMrX9rmSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxvuhFGyYcnEFbCPgvDB1H7cn79rwkKs54U5nhXao9s=;
 b=rVzgEuGM1eUrn+054666+XCrVYAJFdTCnq0poHOcoV9jSQW7nibtUtNhqfBm/0HIS7EwNgzHjM8fZi99D5VKberMi3gm88SSKHr8OvAP4V3y9bBACgt9SfIZWmiS+Z260ZGc5HXHEJk1uQeO8yDzm0+Ksklzz2IyrdQ+dtFKPeg=
Received: from CH2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:59::32)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:48:07 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::21) by CH2PR03CA0022.outlook.office365.com
 (2603:10b6:610:59::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 16:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 16:48:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 10:48:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 10:48:06 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 4 Dec 2023 10:48:05 -0600
Message-ID: <fa208013-7bf8-80fc-2732-814f380cebf9@amd.com>
Date: Mon, 4 Dec 2023 08:48:00 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
CC: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
	<sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, PCI
	<linux-pci@vger.kernel.org>, Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
References: <20231201224556.GA534342@bhelgaas>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231201224556.GA534342@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 77944529-0d4b-4470-5329-08dbf4e8cab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRFbRb8jv8i8S0lAK1ld7ffp8QuHlOqtz6bljygywXyyD6ampKXaXaUqwRk0p8Rnwj38o0aJLQUuC+Dr/0P//knR4qPehs9RHLMgryo5+m3u5OSn+9Zdx/rODDg/E0TCrpHbwzFEIRQSZMH7dsrDU9HoPsQJ7ShGivp7aaDWHxTvroac33EtrAZ+IEFHgt1v2sASb77FxuFLpgWGjkRu9ocXH7Wl60VycKCEvufJCdazVQgPrQfnV/RYE96+rK/a5MoN1GYBRNB20HHRVZQzmALsIC7aijrH9W0ioNUoz5md9vFIsBtoESDibXvKew1yVdnnS7PjQr7GcLbrQM9GADzgCgCsLF+Axc6N3e2oQi6O/DD/ng27B6obmDliO6lBZbucqBT/p7/e0JFzpkxtR4tAgSmfAYdVGu8DcXqir+OWbysvoyrEf3ZpwXDvpO/k6gAxWK4UX5YEOmRh5zTqxV5IBYEsGEGkBRgX7Hm0RkTXanVktg8JSAuVRJ9QBgv7BtQl9JKo/Cepdz4CWkB4rAGFp2ysZ/Fy4xEw4Ivokrxie5WeafzQiozjIYYQ2BNYZBGfQY/C07+DOSfusLAYENiMWCT2KfOOORiPlLiT5bfu7M8odi3y809SxxUHka/bs55NJZgUrsikMQ0DHyWLcGrfX1KdTdkdRccuCWH6OXJlqh+xiV7Q1vr2mG/UOS850Zrz55+bpda+evdTkl6Ivy7xoW4yFdZ78vAZBdxzjZyZ8vjKiPBc4XoY8XrM0tyPI8t5VQGEt43T2EquJ4fyr7gIfspAraU7Frs2YXK2cEk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(426003)(336012)(82740400003)(83380400001)(966005)(478600001)(6666004)(26005)(40480700001)(53546011)(2616005)(110136005)(4326008)(316002)(8936002)(70586007)(16576012)(54906003)(8676002)(70206006)(31686004)(36860700001)(356005)(47076005)(81166007)(5660300002)(7416002)(40460700003)(2906002)(41300700001)(36756003)(44832011)(86362001)(31696002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:48:07.2877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77944529-0d4b-4470-5329-08dbf4e8cab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

Here is the link I put in patch set cover letter

https://github.com/houlz0507/xoclv2/blob/pci-dt-0329/pci-dt-patch-0329/README

It has the steps I used to create and start qemu with pci bridges. 
Hopefully this helps.


Lizhi

On 12/1/23 14:45, Bjorn Helgaas wrote:
> On Fri, Dec 01, 2023 at 04:26:45PM -0600, Rob Herring wrote:
>> On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:
>> ...
>> Also, no idea if the bridge part works because my qemu setup doesn't
>> create bridges (anyone got a magic cmdline to create them?).
> I probably copied this from somewhere and certainly couldn't construct
> it from scratch, but it did create a hierarchy like this:
>
>    00:04.0 bridge to [bus 01-04] (Root Port)
>    01:00.0 bridge to [bus 02-04] (Switch Upstream Port)
>    02:00.0 bridge to [bus 03] (Switch Downstream Port)
>    02:01.0 bridge to [bus 04] (Switch Downstream Port)
>    03:00.0 endpoint
>    04:00.0 endpoint
>
>    IMAGE=ubuntu.img
>    KERNEL=~/linux/arch/x86/boot/bzImage
>    IMGDIR=~/virt/img/
>
>    qemu-system-x86_64 -enable-kvm -s -m 2048 $IMAGE \
>        -device pcie-root-port,id=root_port1,chassis=1,slot=1 \
>        -device x3130-upstream,id=upstream_port1,bus=root_port1 \
>        -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=2,slot=1 \
>        -device xio3130-downstream,id=downstream_port2,bus=upstream_port1,chassis=2,slot=2 \
>        -drive file=${IMGDIR}/nvme.qcow2,if=none,id=nvme1,snapshot=on \
>        -device nvme,drive=nvme1,serial=nvme1,cmb_size_mb=2048,bus=downstream_port1 \
>        -drive file=${IMGDIR}/nvme2.qcow2,if=none,id=nvme2,snapshot=on \
>        -device nvme,drive=nvme2,serial=nvme1,bus=downstream_port2 \
>        -virtfs local,id=home,path=/home/,security_model=mapped,mount_tag=home \
>        -nographic \
>        -kernel $KERNEL \
>        -append "root=/dev/sda2 rootfstype=ext4 console=ttyS0,38400n8"

