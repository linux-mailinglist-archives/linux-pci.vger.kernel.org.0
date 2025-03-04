Return-Path: <linux-pci+bounces-22903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77CEA4EE1E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018843A5F95
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB624EAB2;
	Tue,  4 Mar 2025 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BAATAnFb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AC1FA243;
	Tue,  4 Mar 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119144; cv=fail; b=Dfv5kmN/PFJD3OahzeSgrpigSyNahDqmUPktWE2PIrsmOo6T3g1nVL9pCK280sB1bS5UI6KPcwo3BVp07y/XNiNd5Z8JDJM6sYnOgCyjycs0QznC26j63PRBmeSHaX7Uwx4/rajl9a9kZnomdB8RDDtrPzs3kzGj5bJZGvszYXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119144; c=relaxed/simple;
	bh=2g6DTUuLF6ZuEIciA/63hzMpGRI3QSbV4pdZVXco/04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gw5x3HhDQ1fdNnoIZiMcu5P55DDtqrQ1JQlji/waN6dC/btR9Nr9bjrq7ateKYs2SuCiVhUkBiSt/ql+OKneHVoCx+nOm24pFiD+0eSHwItVaJ1aC0bEalqF7Oi7SE1J+Fc3QP1zRKgkPf4MHzFISz7Z/CKNKPdOPsZxTL7UZQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BAATAnFb; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3nnEZo8h0Z8jAzcE9QcCXgHtEjXTA5YJyRw7hGvWzovy6Z+l/HXSkpLrjAE7yAZnFCYlZmuliuAoaPbjGUYuFfaBbsHn8afR6uz8Xk7icXiWbbrY3ddeuqNlktNuawWHtT8Mv9jyXjowRd7e8KXmxtDsy/IyWzKZOrjeUu9TLUd5agKyOplGZNMrarTjvQRlVbqF9DIJ+oGa0gDR7/S0lsbSmPeA1CiH4ljam8lS7Lk6BXc6lbfijI5XP/jeadWtyQnnR7FWButhaIaHz9QXIOibmSOV4lDofmC9PYubjxajw+hJ9DIVURVguDmDF5IATsGtOYSJajJRkWukdUFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g9Ylkrj0zvs6MBp1J92qVNDnO0hirjALMJPAwTsyO0=;
 b=Olih8kEK4b5FMhd+Ep8THAWHXkjsTanNIUezkGAuzCq+JKTsXDC0vZzCootjkOGYjBXpgflHxy5N9U2qBSl63fZm7WqtFAYRll8Bp4HgBIYFMaPo2aIcon7w7Itxzm+VCeum+kO5TK0Z6S9993opDuqnZuRUW7GYH4riiTbp7awLzCH1CorcRqjNXRRXRe7RrIdNIfuMkbXFNf0S+Q22qM2wXDU6+QQaiOrzUpMde8TH2sdbKtyRNh8+hzxriVck5m6HDsBj6/lyYCxDl5iDys5v1PPsnl2AANNUUHW0S3UwfqwQDjbVsX2HqCSv8boTBo2pc7nGae5TF6MO9wZ8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g9Ylkrj0zvs6MBp1J92qVNDnO0hirjALMJPAwTsyO0=;
 b=BAATAnFbocvvG580s+eUBDbhNdToFhDG1pqA91DpWaC03MIxZ+b/uY7e6018RqnPj+UzM9sJuDfq6GjCWab6VJu8tEqsa8Jy8YqoOFB7wpQRdhrKdyky9cDzXjIRhVmU4Pvwhn0q/cf5iod2iwIPuWoA8RUSuIBJrHbXqcbeHJ7KdZ+Akm4DAkm2ag49NaGYjlSYj7/cMnAMVTLcQ3guWc5OxZXv79J/IACZfC1egED/KI0zeSdltLWyfsU43Zc7ouk+M1dZoyOTePQL/ra0Q7xbfHockgD54HuVgiRSnUHq2h/8f4FsAeHzSo9Mhtecfe8pUEflfFBFSGXEpn6a2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 20:12:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 20:12:18 +0000
Date: Tue, 4 Mar 2025 15:12:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 2/2] PCI: artpec6: Use
 use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
Message-ID: <Z8dem5gBf3xLxSIT@lizhi-Precision-Tower-5810>
References: <20250304-axis-v1-2-ed475ab3a3ed@nxp.com>
 <20250304190816.GA253203@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190816.GA253203@bhelgaas>
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3994af-773c-49aa-02e7-08dd5b58dd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P8HjkAGrJzShD1rTweKwZeyWU1IWUvP+AswRSiGSyukzXWNrVdICy+SGJ7gy?=
 =?us-ascii?Q?q1Az7dfoA5aec02IxTKAuwWe+pbBirmY9RbkA1wWfoGvqlKBF/1AZXdxlJqG?=
 =?us-ascii?Q?Aw9nzNT1g+SGjg5wN5G5dUH5w2YNnquwgTWUa1zO/5SnJz0d0zflo/BwWAa2?=
 =?us-ascii?Q?qtQQ/YEWLvSFQBqcBYC9WYgrjLfHXFIm8HKebtEfMqBhQSoPiSB8KddEQJIq?=
 =?us-ascii?Q?jprzgsJOvx5NapvJsZDW7pKgpX+uCQxyOwM7/HxmrqDTdFSq5oVSIp5nmuAc?=
 =?us-ascii?Q?3nEoC48jp7OiH6UhiWN05liImkQJfFjIsvVrNk8Ow3uxiqh3rvTUK2CcoBhP?=
 =?us-ascii?Q?b7ZLXRjTcBJQ4D3YWjHEoZJhwsRqPboW7mrWnKdHOQvG7LmXLtw2k9j588/U?=
 =?us-ascii?Q?AEdEyS6iKf1gL+WNE4dpHd7SQpM2WsGRlevf3o98rWSwkUMGnAAOxnwN8Mos?=
 =?us-ascii?Q?Nfs5L6L4m4/m+shSbaRaLcHfcLHhOVW1B1MBQmL/5VwqrM2FVKY2f2ctizhV?=
 =?us-ascii?Q?6b7oGiXf4ztzbFX0z2j2B1STlgDUxVvowAm5fk7TCJpWwktWNIRsd5gvcbzZ?=
 =?us-ascii?Q?VOhs/y4TuIg5Nu6PHjoskz6pL6pYr3SJTsudj6puG+ux7eKVybB4He5qSiyR?=
 =?us-ascii?Q?67KUCzwXU/iQgOs8/nmGWlmxlrdX8mfLiYIcYKj7jNyZTgba7mqzjzl5N737?=
 =?us-ascii?Q?bVSUz77kRKbygfq4a1HT4tgCoQdjslBc1oHXRtryI7N9L4UBNxzkGDj4AvrT?=
 =?us-ascii?Q?6ywg6Ok19mso/eqBt9grXjb1WVW/eZrd5nYNPvBrdCHmaXp2l7erAPD7D/sv?=
 =?us-ascii?Q?L6DYhLtYoR/oPidt8y6v9hyDgwlDO35G1lGTXO9Trk35IrD1L1+9DZ+v31bJ?=
 =?us-ascii?Q?WhpMWGOOsA19ZF9BHTeChq6rw6s84Eu5kUc0RH4mIkqAovvG/iV45XsguxpY?=
 =?us-ascii?Q?V5BW1cipOV5c6fop+a36v191zhAlIV58c3jXMmEFTa2UlT98f5sqgLdYuhV2?=
 =?us-ascii?Q?PjXjZ1Uc8y3TePxOEx5a5sxLbxN76jXw0h6oQlS4h2WhQwElPToKkO+yuvFE?=
 =?us-ascii?Q?ijSYkheT4sBW4yqs3pccEYBn6AdQHWRyd96IShMZ3hL3YeuHW6RRhHWhy1Vp?=
 =?us-ascii?Q?hvdy37xhP+yejkjG3B1wKsc2SR2pAdEWjZmtGqnoVpHNlIqJ2Nd/v+213Uay?=
 =?us-ascii?Q?wOMzKyMRlndPGX+VDuH75HtaE2ykE9Q8G0pvdl59e4hMtDKfYfjBFKQmxeCg?=
 =?us-ascii?Q?ZSnm6zzLTXCb5mXzpEegzIg5xINdA65UCFt1shrknxo0f+VsOoHaMZf4pMfO?=
 =?us-ascii?Q?XZ+Fvbfp7Op5Dl6TRDm0LUqnzdVGIsSo93643h7J+AenBA2bPauPYqptSEl9?=
 =?us-ascii?Q?GS0Oo/RHQgKCI1pB18Iq4C4hhTcxDe0Kne3Yg9vNBaZRqVvKPf90uEYbEnnV?=
 =?us-ascii?Q?1+EAuzdJMb0gcsX2LpEssznbCKSld+YQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tivasyD6yCZjcCfyC07lq24JeJbtBAfEEbyP9FYA6LqPbxorBENAON+mWsL?=
 =?us-ascii?Q?bl4McpS4BWqUnFq0cw+Ws59O1KaR/0jXAB7Tv5IsjLRsEN12JJCmzTb7byGX?=
 =?us-ascii?Q?AhoD3FeNod3bGeDTMCkchN/r7UJFwcYGmeydoczydJ4Gx5HK4RIyA6r/ofQm?=
 =?us-ascii?Q?zQZO0dQekd7D3NPru9ltrZ1rStcrRvra2nG7OCIss62tlyV9KzGeBn3JgRqG?=
 =?us-ascii?Q?9Cb+M9qO/Chd44i07J9BhbhaafU59EOu0YiS0EYoEQdKr+8oOCsn0+d+7b9u?=
 =?us-ascii?Q?JoCNiKB6GK22ALr76uH1QLo9pCqN2soaIZ1L0L/qkF51kmLBSsK4QGhaan9H?=
 =?us-ascii?Q?MilIjMKX1LhgzjytxxdKAtagMlYz9nyCgXSKEeuYDnrF0Z21B9HimBcqnLov?=
 =?us-ascii?Q?9Cx28kV94gaTUvCJP3R+GsJoZuPteOU9YQFaG4lV/9AcomNHxW4gNwh5CnDs?=
 =?us-ascii?Q?/z3tttq8ElG2csgyYIGLeA94UUZv6XNKbzgJ82h5VwvZ9Ki5B31Do5/sXs8c?=
 =?us-ascii?Q?1a+W8DUlP0rALNBLNhzLYQthV+ryIV9PxyG740ktPBnSrybGVJfXn+CQ2XC6?=
 =?us-ascii?Q?36eO0U/yXxhfaqzHxQFsI4hLepZht3xWUnl6yIgCq9HcGBvWjoe+aDx5Qz1t?=
 =?us-ascii?Q?aIBKEKhbrWXLF0DlWPT1l5XyKm9MlIJSPHPAemDAVKSsram6UTvxGBkQIdCU?=
 =?us-ascii?Q?jTF0nSCa2hX0VLVnYtyBcV58oAkA9fGdENwa8xJWGJ4S7Qf9UOvxKgoBYKCs?=
 =?us-ascii?Q?PhrLydXKRkjzTbEeUJFlTMQMzbWffU8sxnZ0w4pU8x5eHds52OT61A4vpEIr?=
 =?us-ascii?Q?GMSrNk8FixUwOrwW7T/L6qpyqjh+RMV91KP2M8Eqn9kN3Gox/D17dDPZAZLx?=
 =?us-ascii?Q?UHxZmmKWyq313jiKm7wHMZPdBnqsFzvs0ogGuNb76OxvLYUPwgUJmYFqH7iW?=
 =?us-ascii?Q?TEUpq+qtIYvLWX9ST6pDzIqJrG1yeE8o2Fset2eV/71BhQLd81D5MEctOScb?=
 =?us-ascii?Q?HBGUGpJvv9ZAYoJvYloGcVMv1D4r5wj6fvjAVh9afd9KnMHZsPfXKlQe0l+t?=
 =?us-ascii?Q?hdUNabHlVVojQ3Mfmr/Bewt+4zIvEUebHFKcpe9W4NHYooD+CVQKsy1WZ4L6?=
 =?us-ascii?Q?I43FHVzGzSKU7gw9r6jh2a5ci2l3cQBalImxxSBMdonu31Hjna2da1m9S1Nl?=
 =?us-ascii?Q?gX9lBFQ3LyKRdFa0yh4ol0e27e/etgXJH+3yXDeJEoybn48VB2ZqBIPz6y5I?=
 =?us-ascii?Q?lWOa5pOhKkA9ohJWvmfHuP8lig2qR5Ful1zBSgVb//IwCXblAqV9dhsOYhVR?=
 =?us-ascii?Q?YT795mMzfSwej4hiRIvXLSSy0f1xSRy14dkAj0AuAQI1zvS02gvWRW4TkzQW?=
 =?us-ascii?Q?3IeIeeq/HpA7ViFdsm1MW6KxjPJq3J+vMPeln+8/zL2oD8YeEGJS+UTmQL/h?=
 =?us-ascii?Q?5PSdk4IrDYfhk9U1ChqVBTQRSDzRu/5yQKah7ThfypFftGItZ6LBfAy1aFmk?=
 =?us-ascii?Q?NxXF1Y+llWMxXkdFKrTA4GmK5U+VsE1qLEABN/W2a3mOzyj+trIFFyrOhSnM?=
 =?us-ascii?Q?psfPQq4UD2yxc6ZEVgg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3994af-773c-49aa-02e7-08dd5b58dd6a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:12:18.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bERbnVMar+3SF291DFzxNmxK4IhuHpbyRoWBuasm1cLbkBT6JXURHv9oR/37uJsHuG/wkcASBgXC1fzCoYa7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

On Tue, Mar 04, 2025 at 01:08:16PM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 04, 2025 at 12:49:36PM -0500, Frank Li wrote:
> > Remove artpec6_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
> > address translation. Set use_parent_dt_ranges to allow the DWC core driver to
> > fetch address translation from the device tree.
>
> Shouldn't we be able to detect platforms where DT doesn't describe the
> translation correctly?  E.g., by running .cpu_addr_fixup() on a
> res.start value and comparing the result to the parent_bus_addr()?
> Then we could complain about it if they don't match.

Can't detect because:

There are case, driver have not provide .cpu_addr_fixup, but dts still be
wrong. such as

bus@10000000
{
	ranges = <0xdeaddead 0x1000000 size>;
	pci@90000000 {

		reg = <...>, <0xdeaddead>;
		reg-names = <...>, <config>;
	}

};

above dts can work with current driver, but parent bus address 0xdeaddead
is totally fake address. We can't detect this case because no
.cpu_addr_fixup() at all.

Frank

>
> Bjorn

