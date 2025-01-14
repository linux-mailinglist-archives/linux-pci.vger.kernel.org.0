Return-Path: <linux-pci+bounces-19778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B7EA113F4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A71889CA0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA520A5FB;
	Tue, 14 Jan 2025 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTXTKq6a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE14644E;
	Tue, 14 Jan 2025 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893237; cv=fail; b=H4p62HwNVX4y0pj4mvOfbTyDNrkFnPi+hHoiuqGN7wp+Z/Goq17hvLQkC1chJn785lMesLescLvHh1XFYPIQ1Dq48Rq4oOrIoLRV7cbvnxX1FjKNT56hApPR1li9qrRpZpKmQ8eH7o5/CSURR7k3egeoUBwCsRGCKslcd+fQmIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893237; c=relaxed/simple;
	bh=Kcy2IN3kE4D+jST8JRNgJdlpfvZGHiriN47d/PHVd4A=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AiB5jz7uamStRx1m7NRdHmmkysAfa0RTZ7JMsFBklf1Am/gJIodN/CKIUuPQmyy93/hIKyp02ChBXjqrNLNkMHC/PI3uoqs77Ua7ARdslguCcEKvlj2323pucmh4qApn3dEIqKWAmnxIa9J/5UAV5BTlw0ZdX8ntSzpy2EkKR6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTXTKq6a; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736893236; x=1768429236;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Kcy2IN3kE4D+jST8JRNgJdlpfvZGHiriN47d/PHVd4A=;
  b=gTXTKq6aUHxvvN1kjttkOLetmlUd6kVUmK3AiMJilM0cz1cL/zRtzNB9
   TLaXUKJ9FPn3AMlq1lhEPwdXJJlwdrMp3gVTDyEAedFS7UJhJnZRDPDmW
   MZuwReA527AXWx5jIGJ+2KlcqWbsiTy8hLr/iky4utKkbo5N8zke/cTdA
   5svgmspBbQt8xuKllVyk/JeNXKqf8VQWBxQxc1y2D4OW1TP4Yf9buqkqC
   P1+K1NinTSMGmeliHjuRBnzIoqvPFP3jDxVFH9BJ0MLJAHCzhFptLOTsi
   9zogGorfG4RTzEouPVRbyXlSbkAZ2J0hTUYsG6O/8S9FhTP2Thk8JINna
   g==;
X-CSE-ConnectionGUID: EYozuse2RjO3RL5ltOOUaQ==
X-CSE-MsgGUID: 7QRoU/BLTciYMrsWuThQMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="62581063"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="62581063"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:20:35 -0800
X-CSE-ConnectionGUID: gDHauubuTWWD/ueJczPHIw==
X-CSE-MsgGUID: 6Mu459L4Sf6to1bioOOCTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128182486"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:20:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:20:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:20:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:20:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cuid4V7k4rz4L4C1UWTFieqgrTLHl+rCSxXPzTmxhHf8iZpDewFt+zFaF06tJCCF4sHP91DLgHD6xNGQsYQ1rSD6B/d7x0j/DhZtca2iZOXo7ZYnom0piF8gygAKdL3LIW9T626LpvwPh/qJu5rz24XBM7x+/NWyV+gGiwGCyZ1d8BKPoVGi2GOzrL943bqakzKG7Uh0FdUygNE37YneCMeTFjT00jg7X5Sm4VrxMxDQfc3IF9v2LGJK54E4wUUrt1XCEb8UUnr011HhTgn8GgNSRmio4LEmeyXRfd7GVyKpmuxJMofGli1N3wIcOvsRJjjQZRxGAsjOAsUxAeB+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/HCrFtZlisRZVRJLh2YJGELFIIR5a+aKn4HyjX9hYs=;
 b=ibfOzZJ/MWXj9R8nWghPsJpdnwFQmStkvHU+s0x2PpY7deMSEWbWCGtv5oNnsC0gzMVwXsU6c4KuO0CeBWs+yMdmWEZCg4h7cB9yHFqRv6lF6zAQvWLURCb/CkK4B2OrxYdZfdGxd1WgJVZCdoHDcgyvpimvDv1zh4ymJqPtruhL7GFR4II3iJaLFFgVV453Xq4Et9Uh/5Tm5t8Fd4naXunwTYLT5CqOqR1IZF6RvM/oghoDahMDmB69hFYsetQ8KXq16PpTBtOKG3XDJvjEBwps6LwOIQWII0b2+Qx6OUEVLiljnrpP6CEOae5D+fkimceE9CDXK73ywFsDcQ6+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 22:20:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 22:20:31 +0000
Date: Tue, 14 Jan 2025 16:20:25 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 10/16] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
Message-ID: <6786e3298262a_186d9b29433@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-11-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-11-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 372f73c6-31ea-4810-9986-08dd34e9a851
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCiLzgqK+Q7W/o7roFXm2tBU0VQwGzLRhJ6VJxRwCWUbsXEv7By3TVQRQMJT?=
 =?us-ascii?Q?WzMKSz183Xu5cHOvtzPxru3lY3fbTND74cq0h7ZQMP8QJJ5HICqFHEfd8eAX?=
 =?us-ascii?Q?rsHPlzgRN7/+QxslPor1KA2Q+rm0ZGoMZ57GX/JR7nFJDcWAf4d2wPh2eosv?=
 =?us-ascii?Q?1dPbCVuD7aoIuklrcp/lgSrxI4II3pdjSmqszLyTWb+7EtG5T0OlCpMT5AnB?=
 =?us-ascii?Q?5W35IN+3GuUPi/EuXc7rzGhl6yRnFA/IC57POP1UBnOB8QZPwyJhLaJmf8jp?=
 =?us-ascii?Q?xIDpQEyQXK1K+KNTOa3XGNc0dTtduxkPo6wpv2I6PaZGqGMJhveeLo8Ab3s+?=
 =?us-ascii?Q?pRalm4Dn1vBAYNQF7VFs/8aOlHs7rc0DDsWcvl6PJ9vCsv51WcyBKWnA//GX?=
 =?us-ascii?Q?BYne5HutmHM+ZAq10wghm1zPwjXOmr9gu4wkUFsuUPSHhcJdpQhEWr4myv4T?=
 =?us-ascii?Q?Pfky+jPJ1LHIutN/ER9z3zt/z87dOsL3fhHRtgrhL26FO8+Lq8KUp9Gf6R5I?=
 =?us-ascii?Q?ykvJt56rL7w1M1Fch20wbhEFxnvKRaYRykJFWF3A/2l3lelOR5CTwIpQQCAn?=
 =?us-ascii?Q?UYvJNoAuso3cpE7VhYcQOh54gNwMHXYNirDxKfRqn7EgxfE8AETpfHtUbvh4?=
 =?us-ascii?Q?AXQi92WQ1HHmoxWxwWbY/jrj1jgIEKljbPPD0POsYFcF4qnvgeAZkcV0QsNz?=
 =?us-ascii?Q?ieP4YgGrMiRblewVDsy6EYME7jvZTkEBqKg6nVp7JtBlvC2YpkYBrN8p7Mh3?=
 =?us-ascii?Q?bGS2VzoXWBCoZ7apzDrF/odfwAPPw+Gcnc1JEYoc3MU9SvSlhprlXOej8Gpv?=
 =?us-ascii?Q?iEuvFv722LIpNQacjvm33lKmX+N7KCvfTKgHrneaMOCIJ5uXj1raFJW7cana?=
 =?us-ascii?Q?xx3x2oqA2kgxdkKPp+SF7Grrmzt22uoUhq6Y+Qnf/wpXEHTGkLaidf/bVwuS?=
 =?us-ascii?Q?RzkekoWMnPJR2gGqJn8PzdW5aqcGXf0FaptaMmXg0YEcSH0J4UCwRp5N8Shv?=
 =?us-ascii?Q?aGjvcw38Bv/E23JZPDWXyqBxE1e4ZqGKIlK/P0Pb2m76wo8QhMNShIfTjVXQ?=
 =?us-ascii?Q?+PYrqL7RfsXYzl85dfPLQMlNk5iiy++VDhUthZ8vTTn26/6j0PQsj2wZBOJv?=
 =?us-ascii?Q?JQLExCqhEydyRXN6N5dVHFiEr55cu9G0E5U2xz5rabH7DMaH0tndrw/uN5BH?=
 =?us-ascii?Q?1YA8u6mRGv9GPBHv1XpNge4Haj0pRHfJ71dbBGS9Oog+Wa0dfieIWCH8hd3L?=
 =?us-ascii?Q?o07NfxOu+rQxWzyr7J5mZGCxmpHqR9/05/bPVhmBugc8mWmuo88gB/Wu9fbb?=
 =?us-ascii?Q?5KCrnCARA/DXSCmoJstwnOlG3Z9h/WDJXkWHXUSKLSMjSm2jaxF2tVKBuOWT?=
 =?us-ascii?Q?JU2woWVZgJRWYQlDWPNVqCGuRDZSve725ZxL+jHcqFW3GXyNCDl5HIccpQv8?=
 =?us-ascii?Q?ljZ+V1VA3S0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K98nc2c4KjnDM5IEGYpoKy6sdidqFkFa8A1YI1aAH1LaTzOgF7k3u2bx9gVt?=
 =?us-ascii?Q?tVL/oVUdKHCirRwNeS4LFsuB+jmblgdn56eW8/ruM7oF6i06IKWWBlyqsPf4?=
 =?us-ascii?Q?FqDwP61T7uCzYPVVLApSNe/Kd7ZxGYpgRFishh87YK/16H1Us6i6jTjtVzp/?=
 =?us-ascii?Q?ygAVV9t2VFAeHTMpSm/GDoHyrNk0slMOIJ57Cn0xLEd2ih4S/A4JdPT/u2+N?=
 =?us-ascii?Q?wi5oqo2cUlH+KWdHlFFq7CcLbUVSuI+DujThX3nBRIiznG8nhtxdBoUrvzH9?=
 =?us-ascii?Q?y7AFoLF2UNumaxj3HP/TQMxHFshp29Gj2G4wTHUqix6YaKye6mfoNqB7Gwn2?=
 =?us-ascii?Q?/h56b81TxM6CH0KHeqAP70oy05rXUARzv9OuA67t6ZJmJOw2E1NM4AJXKLyf?=
 =?us-ascii?Q?kMRWPSQPhLkb8rwiq6o0o8WSkYvVaupIjuvM9FOilUx3xRDy8/mt/JAUYx3S?=
 =?us-ascii?Q?rxGyJEmRPi7rnPJ9WBH3PuFHkfUhYHEGZw5+Lm4AR89GGy17FqMHrOLhWMsN?=
 =?us-ascii?Q?eFL6HJByDILyLv3rRMkpAO753htxPGTPhAK6VUi5T5BTW8iXaiBgrISNA40R?=
 =?us-ascii?Q?L+vbpZPjFFw3tilOfkmKsuhL9DKToWuy5rGkTbN9VsXfpBuxkLshWU6AHHoa?=
 =?us-ascii?Q?z91Fu0O5ZO70Jilml2fJjf0Acq3eXX17V4PCLvWur93IBLYnSm69VmO65gfj?=
 =?us-ascii?Q?OJ80guNnjP+JdDG9npQH4XMhYcPyvvTKPISlIYariHRqpBZfDQHYCwfnWgWR?=
 =?us-ascii?Q?LbawAcVnxRL6+9w650fB+C4hzZodxP+omBt3jEpSyTqMk0Sko9go3N8cOBkA?=
 =?us-ascii?Q?g/nyrHcRTd0uTyh8XEpSQVaUribp9oRy83EgqlH3AffezcmPB/heYhZyoUjc?=
 =?us-ascii?Q?+Im/UhnEK0f8JrovUnWcjqILIULP/FGOZkDVsN9q9v8tjKIfYyXjZlayzDSH?=
 =?us-ascii?Q?DeZ2KaopQwp5ZS1SFFGRyXdZFAM8Ku0t5YP2OjmsqNTA/GaNh2jsbeFNEAml?=
 =?us-ascii?Q?eataBOrO9hZ39kIePofTU2XHoVGgNbjcPpmuTp2Ei2eOb9RFrykppS/zZr/b?=
 =?us-ascii?Q?O30hmHQ3eV1OHchAGVJDVKgC1Mnv5ivhlToOvEVTbtVFkgWqKCoRIlLNLc5r?=
 =?us-ascii?Q?1zhgaiIweRiUr/2Zys08F2v5N5BYfl+Umdq/yofSRA+FA7tv3H17qubR7ST/?=
 =?us-ascii?Q?T/tT0T3sXtpBtjHvUiM6S7LcgW2SD2hOiKTrGE6u7b7XikyPQCuj7KWiSP0Y?=
 =?us-ascii?Q?ocLUCfZFbg4DfUeCu/e9k5b6QO1RJ1IuXaLwQYT3liffxnZgVGEitgVwcQGe?=
 =?us-ascii?Q?Y49A37JPNbjWG77YIPbG/BQuQdX/bvbP37wFggioyUx90sl7kQIanorREZ23?=
 =?us-ascii?Q?5hunGLmnqNi5OYqkaN4vJh7hgJfqaHwFD9PqSih/O6ipoHvyFn7E8L3hKhxj?=
 =?us-ascii?Q?u/WOoOA1Z28CIe73QCkAbqgq3nLqmbAmyue8ViOgieQlzheIm6KAPhG3cud7?=
 =?us-ascii?Q?zuiVhfvIuNTV/5+snCu3TVSCcYX5opn90YJTNstHqcRhA/sOnk+DeaStGtxP?=
 =?us-ascii?Q?dbcipz7zyJnhSez9fUo6Ues8YekYmyf/itZS1o2D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 372f73c6-31ea-4810-9986-08dd34e9a851
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:20:31.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmF8fE/QgIXcg2PUZel3jBgWMgBrYGRG+5autvXOnjs6paijSCVoAP+2DNcEAVR7F63XZZ6YNa0RxtErVYw3YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6190
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

