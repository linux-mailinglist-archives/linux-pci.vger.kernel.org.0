Return-Path: <linux-pci+bounces-7326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898298C1FF7
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF881C20DE0
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269013A41B;
	Fri, 10 May 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iFJOcjhr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AFC79945;
	Fri, 10 May 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330556; cv=fail; b=oVVudO0NFtre40OrKjiQ6BbCroPzhMBZzAXdagIkBaSX5ALUL4xQ4tLhB3BLIgEROm9aq/tfWADm0w65WkO4uuy6DXISHoo0h3fueEOOHvyfZ5GeVyQgIJ0ArbUTBIozCASkqOX8ZPA4AFlA6Tr95wBhAUhsETkvEjrQLs0rOwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330556; c=relaxed/simple;
	bh=2/oSdE+eyGm1cwEYkGUybu0Kw1gWDAc+wgB0BtK8ZJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbazmLg1znjBiznCySV4ySzrG8N5WXKaTw+qqBOItqAZSjcC/DfUAo1bF9nGaELZgOa32OsOjALh28CVtK7tROK0FuMOrXHE5NMy9jdysrW+vpJy9HlUsLWl+rreANoBFknQSQPEhu50VrmeImGvQJPMX9TSvn4aSz9pFFATWcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iFJOcjhr; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q31kmu1URS2/jPZHUjbpUAL3YXK/GnC3dv4ylrh2jH8mOeC44gy4kk3gJkK6uDmC+qgrH9yxyA8XoHnzqrLPPSb30QQJtFbkKH+FxigWQIkfj5wZRUDix7OO2/JAbi5IjELuQB0cujLsdTCIGj1AioR+f3TcwLZmuKmfQbjl/+ADgAm6ofmc8xR/44wywqIOGheldKZJbaG+W7CF5BrDiGSRDGGdYT1Dld2mdZW+IW5N44OyNbhXucxvfulnLPWkZEFdqd2+T2CflhVUQLUxjmnBoP9UKsVrih0px3gEJFBBZIwWk7OuEzf3Siz6rsJn7UEaPJXOn5j7s1nl73hW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/oSdE+eyGm1cwEYkGUybu0Kw1gWDAc+wgB0BtK8ZJk=;
 b=L2NrbiuO8tDg0qdINKci52V6h+R5dtoXzEY2k/bgYyAYpB51af6kz/fynA3l1u6i6CWHWKNgwehYh1ZnL1wkUF7+vxfdM9QIzGS79iWr3nh/gM9PgGYmipuKk+5q7e/a6fyg1hBhOk6ILYaPlGRbAvkUYzrRz25dVmvU4PyOdUe6LZYEu7o0fAqZO9aFHmZj9G9EcM3GDOccrZj+pderr94Ey0z/kQjXYpLmLzDAbS6O68bodz3Tptj+GFuRk8R/99vXhcCkYPErk1QztdG/8Fd5yYfrar7+Wlb0L3CJumJtiQkFbGF4Ps5ycuEHMmN2YGMAfvOZXWVgFQUo9qMb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/oSdE+eyGm1cwEYkGUybu0Kw1gWDAc+wgB0BtK8ZJk=;
 b=iFJOcjhrry+aMzvhWHjcAajEqriBVEnHMAxWIDYspp8xK6zMMa3BsOORof8KIvjGUmT/5hK4kyoHbuyOWRXs+lG62YYv8YfHx/ZvJZZDDB7mW/Di8kFYWjFyn4NjskUt/OXKIRXP8z3/UG+Q2K1a6wtgfiyVrgl3GTqorgX3waY=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 08:42:32 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 08:42:32 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v6 2/3] xen/pvh: Setup gsi for passthrough
 device
Thread-Topic: [RFC KERNEL PATCH v6 2/3] xen/pvh: Setup gsi for passthrough
 device
Thread-Index: AQHakgrNAUhcae4lxEaXCyVvErnSM7GQOM+AgACN+IA=
Date: Fri, 10 May 2024 08:42:32 +0000
Message-ID:
 <BL1PR12MB58492D7614F25F29548F1731E7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-3-Jiqian.Chen@amd.com>
 <9ebdcc0b-3775-4c5e-9ffb-f45d048281dd@suse.com>
In-Reply-To: <9ebdcc0b-3775-4c5e-9ffb-f45d048281dd@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA0PR12MB8931.namprd12.prod.outlook.com
 (15.20.7587.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH0PR12MB5645:EE_
x-ms-office365-filtering-correlation-id: c9de64e8-a863-4023-a75a-08dc70cd2203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uk5nMDR4aGpxeTVPWG9QNnl3cW5mVnRqeVRjM0Fqa3NOdkZKb0p1RVpvN20y?=
 =?utf-8?B?RTFJaXRqWjhKcm1FUTNLdEYwVnN3SGpaeFBjemhvVVNsRHlMLzJwMmxJQWt2?=
 =?utf-8?B?alF2KzJBeVZ3ZnJ5U0l4RllhRG1kOG5qMzMxZi92YmIrWDRZbnR3U08wNzIx?=
 =?utf-8?B?Q0pBNzJJei9RL2ZsMnBIa0w4MUVwZ0MwVmFXWlpna3hmT0VUMFhMcEg1ZjJ4?=
 =?utf-8?B?eXg3OTdzd3BKaUNUMEhRYkUwUnBBaW0xNUxHM0N3elhnNjNpOCtFS0dOM2pL?=
 =?utf-8?B?M0NEM3dIYTI4OVNYNTMzNS9ORU1zUDBNb3doM3JvNm9rSlRhaXNhTTMvN2Nj?=
 =?utf-8?B?d2NhSm8vZTlibzBFbXk5amkyRm1FSFMvaG1BUGM0SDRzL3U2WHFnbHo1Rkw4?=
 =?utf-8?B?cEVPYjBRMHkzejJCZ3VzRm8wZGZBSnF6dEhleUZ4b2JwK2tKdFR3bVh3QnNy?=
 =?utf-8?B?LzdNOSttTDdRMEx3TGtvQkJ3azJJTXBxVmZjYzRGdnJoVmkzczBiellxY0tU?=
 =?utf-8?B?TkdHK0pkclZrWkUrblBWNFRKd0ZqaXgzQ2QzNkRCSmN4bzdtcEVSNE5YOW5N?=
 =?utf-8?B?d0lYM2RsSHNQOHE4UkljQzAwWWNJRk15SzBJNlVyNC9PSEl4OWJEaWVodGxB?=
 =?utf-8?B?Z24rMUtkNzlFWDFoTlN1RUFVbFQzVk1UK2V3eno1UGQ1RC9lSTVhMllHbTFU?=
 =?utf-8?B?MldESmJqRUZ0cVlmdzJabGxWZjErNmZwQ1RiR216MzlNZENLdUZpRDFKY0hV?=
 =?utf-8?B?OGlXM0JDaTBpcUFuSmZvVzJtc0QzQTVpaTY5ZXd1dXpsZ01rcU5xM2RIam50?=
 =?utf-8?B?QmZCdVhRSzRPVnVrSnJOZCtLWURCWGF2SmdZazRBa015aVZVSTZ5clIxRE9r?=
 =?utf-8?B?Z2lwT09kUHk0TWovcWNmZzN6ZmhsWWNuT01YTDZZQzFwc0sxRmhLcCtYZVJq?=
 =?utf-8?B?SkNpTU51ekM5SnE4eHlTVHlJK0NSNXJiQ2pUVG5BdGpHVTFGNlU3amFtZDdD?=
 =?utf-8?B?VEZxT3lxekpLUElSRjRRVE1yVWdPdVIxSExqV0h0OVFuTXFvYXpPdlcrc0Rh?=
 =?utf-8?B?UDRlbTRSTWFDczJrbWZqclFabkNieVAzeU5GcmhvSlBQOXFkQ01LcTR4ZkUw?=
 =?utf-8?B?blhnZWV0WDZpeVAvMERkWUlHUmtRZkIrNEZpb3VVdWZjbjNER0ZqSndyNUJP?=
 =?utf-8?B?RTBxUEc5ZktKTm9JRThZMTZHSEJtRG9WWEswaTF2blpvOFpvcUxFK1lWRW9O?=
 =?utf-8?B?blFHWkdmbDFnby9oSGMxbHpFQTJFWGxpbURwU2l0NmNoRG5POGVsQVhTL0tL?=
 =?utf-8?B?UDZjTEI2NkdEOW00QmdnQldUalJuLzNnZ296bXlyZnI4bkhtL09OdVVvc0ZD?=
 =?utf-8?B?UHd6eTdFTHFvbGNKWTR5eWVTemhENEFCdlhhelpYZG9yaUZlR01FVDFxbWlI?=
 =?utf-8?B?cytzZ0g0OVZORnpWbmdWU0lsR1FiTTV4aEFBbW1Nck10YW1nTFI4NzlYZ084?=
 =?utf-8?B?M0JuVmhSZm41MDFrMUZrWmVyMm1GOWxOMEZjUHNVendZTjhTSnFySnJFWmV2?=
 =?utf-8?B?UW5BVnJnVGVWOTN1T1U5eVc4dzkyTWtUMWtRaURMOVlxcmt1QURqMjRNNmhU?=
 =?utf-8?B?a2taQmdCK2RuU1ozL3BGMlVac0xNSTFXQmZUOEU3MTlTV2VhUWlEd0Jhc3ll?=
 =?utf-8?B?RFZQdkRzSHg4SkVUVEg1TTNST1d2L2dCNGs0cWpESTJ2MWdFRzBTN3ZmMzhM?=
 =?utf-8?B?aXZxYVRGZmN6WHlZYVhydkRxWHM3d1VGaitxRU1VSzNoM2RSUFZGQW1HMkxS?=
 =?utf-8?B?VEFMK2FkYlZlYVdTM0M5QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M054S0RXNFNJWXZJVHJiaStuc2JOQWs4Z2s0RmExV3hDcTJlSFJZYytBZk1q?=
 =?utf-8?B?cnVrK3pRb0RKTkpKdmNtSzJTQ0lnOEtWWU5DUFVpT3pwTE92d3Bvci9iT3dE?=
 =?utf-8?B?SGl0WTBEUWlTY0k0d0tVTUwvSEVWNnY0VGlhYXl6REVOS3Q5RkJxeG9sMGZI?=
 =?utf-8?B?eG14b3JJNlhETXhyRXpZNlJycVdtTVVOeml2VGl6UFpBMTNhdTV4T3ZvcTFl?=
 =?utf-8?B?bFdUcHVzc2NmVC9oOUY4Y1VXN3Q0YWJ4K2lPWStTMXZqUERJZDBIcUo2QTBz?=
 =?utf-8?B?VU9IZVZFbXYyTUc4dTNINERWeEVHYUtDQU04dGxzcHZqSHE1RHg5OXNwYXNZ?=
 =?utf-8?B?OVk5cmY3SEg3TW1kalp0YkhTa2dBWmxnbXJFQmExaVhOU1ZJMkFvYiszUlVB?=
 =?utf-8?B?eFhTdUh5STVwTnpCMkM5MVFiZzBxWXdvT0NPcjdoMVd3T2sxYWFSUXpDMGhB?=
 =?utf-8?B?TUIwN3NldUtlMVRyRVFwblorcW8wbk5nS1U1STNjNThteGNGdmVuTmppdXor?=
 =?utf-8?B?U0poQmNTaWxzSW9SRWczV3VDZElya2MrQlVKT01VWVprbHVUOHFodGdJNVVG?=
 =?utf-8?B?WkE0QzlRd0ZiMWtEM0lTWTJsQnJ4ZXpWNU11Z3hkbDlqK1lLR280ZFFleGxJ?=
 =?utf-8?B?bTZTaUlIL0tHYlczMHlUcWVteUVkSlNmS1dHZWlnNVNUZGFJWnZYWUJwa0Fo?=
 =?utf-8?B?K0Q0OVpaeVJJVEpKL0tNaVkzN2lDWnhxVm1hRXlIN1Vpd1pOdG5yOXM3TnlB?=
 =?utf-8?B?ZmRscTVNeTVFM21NN0JwUWN6b09RQSsvNXRUeWlsNC94Z2xEZG1BY0dKdHFW?=
 =?utf-8?B?bHFxR3MxUlErVVU2eEZKZEMyZHdqSFNjZ3dvc2hweFpjcm5UenhFWGhmdDdX?=
 =?utf-8?B?VWZUWjhnU3BzK1RoMU56N3k5cGZHVElsZFFmYVF4TG1rSlhBcFkydjFkcm5P?=
 =?utf-8?B?WVVYbDFDV2Q3OUZzYXlOM0orZjQxdE04WWlYdVBoOC9maUJBYzBZRkNqUitV?=
 =?utf-8?B?dXpPcXlpR04xNFJURys5YUVsOENaQjIyelZ0Mml5NzdpYmZLcUlYYTFaNVV2?=
 =?utf-8?B?T3N1dHFQVE9PZzR1dVh3MzNrK0xldHRBYlNWOElIcG1VTlZ2dWxnTFUyZDQw?=
 =?utf-8?B?Vm1JaVFrZmExdXphRG9NQUpNMTU1Z29KV29XT2xLUDFTT1dtN21BNVJmMzFs?=
 =?utf-8?B?YkpEU2JRemZ3aXZiWE4yWjFXc1hsM1ByUVpsU29YMGl0cGF3aW9lTTdyUnAw?=
 =?utf-8?B?UFRiZFdYMkFzSlVKcEhJL3VmY1RabFg5N010cGYwZC94aFRQL2h1alNyNzJB?=
 =?utf-8?B?RHRGTmZLc0IwdFE5anljQ2ppTk9zbWdIemdMOCtQcERHYkRaOHZkSmRKN2xV?=
 =?utf-8?B?R3pNa2E5d3RaMXlxOG5YbkljbjJPOEwwcFdiOTJHVEJXVS90RUV1OFQwekl0?=
 =?utf-8?B?VDZuZ1N4M2RxSkx0M2xFYmNadzdTQ3lxZmsyOUZINGhzQzdwT1U5YmsrbGcy?=
 =?utf-8?B?d2c4SVNYU1VoM01JZ1pUQVdiQ1pNTFZHazdLeERFaXBkT0JmY0hNbjlqRUc3?=
 =?utf-8?B?R3BhY3FibmErOEY5NS9sVVpJc0tyeGtBOEliUWgxekI4cXBNNExHQ0FrdzAw?=
 =?utf-8?B?SHRhdGZ6eGFTRlZVbHJlMzczNjBUNjZ2aXNzNFNFSmd3N0ViL1JvQmgxakUz?=
 =?utf-8?B?OGJUSVNwWmZNZmgwbXZWZ3lwaFlZK3huVElWSjNUaEh2VE4rWnh4SFJnQXcz?=
 =?utf-8?B?aVpQTGdCRzdXRyt5eFBsWHVubEpVUGREWm1pOXIvdjB5dWZ4OStXUEhpcXlV?=
 =?utf-8?B?T2dvbFVzVHpsM2V1ZkpoNlVlckVncE9vdERGd3ZicVFRNlIxMWFzSUNCaDQ2?=
 =?utf-8?B?Z1cxRFVETUhIbisyZVMxdkxEQ3o2Z2tjdHlzSS84WUlrc3ZQcTRTdjBFVytm?=
 =?utf-8?B?M21yYzBMZzVYdUZEVlBPNkNFejllYjNWTWVHTnJnQVhhM3F6QXE5Mjh3OUVD?=
 =?utf-8?B?eWpLWUhvUDN1Zkx2RHgrTU5mZlY1OGxoOEtPalpDUExabnJkeTY3S1hBZk00?=
 =?utf-8?B?dWJVdXRHVTRtVlp2bno3a3luUnRkbHh4OVUwalNUeCtjSGJ3S0tkMjVFUGJZ?=
 =?utf-8?Q?7mc8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96DB0031C092EC429883C1D1457488BB@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9de64e8-a863-4023-a75a-08dc70cd2203
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 08:42:32.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuKyDpcFC+SeD9vUrBF4sbNaFTRVhRrONAO4YME57KxihCikCsK328gME3dxd/NjQs1mXcEyWhnCf5dkseIrvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

SGksDQoNCk9uIDIwMjQvNS8xMCAxNTo0OCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gT24gMTku
MDQuMjQgMDU6MzYsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4gSW4gUFZIIGRvbTAsIHRoZSBnc2lz
IGRvbid0IGdldCByZWdpc3RlcmVkLCBidXQgdGhlIGdzaSBvZg0KPj4gYSBwYXNzdGhyb3VnaCBk
ZXZpY2UgbXVzdCBiZSBjb25maWd1cmVkIGZvciBpdCB0byBiZSBhYmxlIHRvIGJlDQo+PiBtYXBw
ZWQgaW50byBhIGRvbVUuDQo+Pg0KPj4gV2hlbiBhc3NpZ24gYSBkZXZpY2UgdG8gcGFzc3Rocm91
Z2gsIHByb2FjdGl2ZWx5IHNldHVwIHRoZSBnc2kNCj4+IG9mIHRoZSBkZXZpY2UgZHVyaW5nIHRo
YXQgcHJvY2Vzcy4NCj4+DQo+PiBDby1kZXZlbG9wZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1k
LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtl
cm5lbC5vcmc+DQo+IA0KPiBUaGlzIHBhdGNoIGlzIGJyZWFraW5nIHRoZSBidWlsZC4NCj4gDQo+
IE9uIEFybSBJIGdldDoNCj4gDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvaG9tZS9ncm9zcy9r
b3JnL3NyYy9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jOjIzOjA6DQo+IC9ob21l
L2dyb3NzL2tvcmcvc3JjL2luY2x1ZGUveGVuL2FjcGkuaDogSW4gZnVuY3Rpb24gJ3hlbl9hY3Bp
X3NsZWVwX3JlZ2lzdGVyJzoNCj4gL2hvbWUvZ3Jvc3Mva29yZy9zcmMvaW5jbHVkZS94ZW4vYWNw
aS5oOjY3OjM6IGVycm9yOiAnYWNwaV9zdXNwZW5kX2xvd2xldmVsJyB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiAneGVuX2FjcGlfc3VzcGVuZF9s
b3dsZXZlbCc/DQo+IMKgwqAgYWNwaV9zdXNwZW5kX2xvd2xldmVsID0geGVuX2FjcGlfc3VzcGVu
ZF9sb3dsZXZlbDsNCj4gwqDCoCBefn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gwqDCoCB4ZW5fYWNw
aV9zdXNwZW5kX2xvd2xldmVsDQo+IC9ob21lL2dyb3NzL2tvcmcvc3JjL2luY2x1ZGUveGVuL2Fj
cGkuaDo2NzozOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBv
bmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbg0KPiBtYWtlWzZdOiAqKiog
Wy9ob21lL2dyb3NzL2tvcmcvc3JjL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQ0OiBkcml2ZXJz
L3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5vXSBFcnJvciAxDQo+IG1ha2VbNV06ICoqKiBbL2hv
bWUvZ3Jvc3Mva29yZy9zcmMvc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0ODU6IGRyaXZlcnMveGVu
L3hlbi1wY2liYWNrXSBFcnJvciAyDQo+IG1ha2VbNF06ICoqKiBbL2hvbWUvZ3Jvc3Mva29yZy9z
cmMvc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0ODU6IGRyaXZlcnMveGVuXSBFcnJvciAyDQpUaGFu
a3MgZm9yIHRlc3Rpbmcgb24gQXJtLCBpdCBzZWVtcyBJIHNob3VsZCB1c2UgbWFjcm8gIkNPTkZJ
R19YODYiIHRvIGlzb2xhdGUgdGhlIG1vZGlmaWNhdGlvbnMgdG8gdGhpcyBmaWxlLg0KDQo+IA0K
PiBBZGRpdGlvbmFsbHkgSSdtIHNlZWluZyB0aGlzIHdhcm5pbmcgb24geDg2XzY0Og0KPiANCj4g
L2hvbWUvZ3Jvc3Mva29yZy9zcmMvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYzo5Nzo1OiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHhlbl9wdmhfcGFzc3Rocm91Z2hf
Z3Np4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10NCj4gwqBpbnQgeGVuX3B2aF9wYXNzdGhyb3Vn
aF9nc2koc3RydWN0IHBjaV9kZXYgKmRldikNCkkgdGhpbmsgSSBuZWVkIHRvIGFkZCAiICNpbmNs
dWRlIDx4ZW4vYWNwaS5oPiAiIGluIGZpbGUgZW5saWdodGVuX3B2aC5jLg0KDQo+IA0KPiANCj4g
SnVlcmdlbg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

