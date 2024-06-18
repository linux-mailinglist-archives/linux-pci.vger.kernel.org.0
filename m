Return-Path: <linux-pci+bounces-8903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455EE90C6D7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 12:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D8A1C21CF9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5581459E9;
	Tue, 18 Jun 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="RldBv+5X"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2044.outbound.protection.outlook.com [40.107.114.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0BF13DB90;
	Tue, 18 Jun 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698250; cv=fail; b=iTdXL5zDBF0O9K6reW8QktB8MzSHZRBwkH8goiIu981jZ1j/Za9bsp757h7ufWdb8F+Iw/CtTGTO2AtRYvwJIWpyTD2hvT0jLMuzg1tQDAL69GrcVoD/6cYKdgk5rtFJjzZU9kuvsyQtOZrBXxw6be8dcsKlm+kwM0EX6jXtFzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698250; c=relaxed/simple;
	bh=MwIhN7nB+XtFVkE9BVFeDNlYznCpNEzJdWfAea71wPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agGsaDtX1RQ5OGcfjHUHK1bN70q6t7mfwvj2YOuB39+i82IJPdk9RTWxKQnNfDVEd0zT16408J0trs8Vg0fAStoteiT03cbH1GTU5MdP0A5CSzrpolp8ZEIHuIT+FlPg40A9XccrqUtg2sK+zQM/GxZlBAVAOSI/EFnKUCrsj+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=RldBv+5X; arc=fail smtp.client-ip=40.107.114.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b62ji+d8HVkf/i+3AfhA9iipgb5W8+fMTwSSyu/10cfFrOeIhUpKL6N2rCRf2s+ZEkujasjIn378wBFRzHpJhpt7Ykt3H9eoyoGaskL5aoOS6U0mHnJBIsxWEU4Bx9KXbz6UnSzINBpqTMMtFSdq14zgJiexnLCXPziBCLp20tplTxLvy1EHCDh5r6UVq6Ls3AyvOVvU7yGqCz5KKUGstU5QImg2U10MZCjDbqWFFcWVFQUhg3bRvJCB5MO3Vb33ZPY+TKOhpdavmInb+CXoTIxhou2FgijBDQun/lU+npZGbBSxagI15XnPbjGEBJga2KmnhVeEU+zpj8zEjvDWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwIhN7nB+XtFVkE9BVFeDNlYznCpNEzJdWfAea71wPY=;
 b=UKAdUeHPtOFRsoKVeVXyfp9VI31xvRMeY/p4Wn6qZl3ELi7fQNs3nR3i/8EbzKltYyYYbBE9hOzViwRVthJR1WDjPf3kazREbCZiHh2xx3q5cW3sAgUi7TOFNKhEurZmyU3urfWuOgMUcJsCE6X4E0d9hXDx8WpkInN15lN0XJI2T8Eg70boyO9Ucx2N+9F5fNOJxudiUxn0G0wPxCwar60Wl03FAu5w09SHuoTcyjW5sEGJT06mqq0lmb6UqmBLXfyw4DCAbEF/Ej4v4Sd4DPGxn/OOFnoiZw/KQMAH1l1IzzzOa3aczmeqbKJQQSkfo3dKY/xkSswCHIQMgj9p/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwIhN7nB+XtFVkE9BVFeDNlYznCpNEzJdWfAea71wPY=;
 b=RldBv+5XYt4Vdpk5Yoaa3WU+OVe1+jjz61ajoZ9w4shhZuVy3rDhtQllZBIzEeBiNtOuekl9LvFbtaPrzWQXE1EXVMtu3VZ0DwmxvK98PdjlXCUZv1/I8V5j63l8QJeoVlEUx4Q9ewys5hZove94tZ6cmGqSJi5+sW0bLXK3Atc=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB11622.jpnprd01.prod.outlook.com (2603:1096:400:378::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 08:10:43 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 08:10:43 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Index: AQHau/4H2Ue+Yvqse06eFL/aaE81cLHNJOqAgAAPBLA=
Date: Tue, 18 Jun 2024 08:10:43 +0000
Message-ID:
 <TYCPR01MB11040C48B321E9418D274B6D4D8CE2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240618070925.GB5485@thinkpad>
In-Reply-To: <20240618070925.GB5485@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB11622:EE_
x-ms-office365-filtering-correlation-id: ff7a4d0a-45cb-4ca1-3e8f-08dc8f6e2696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?bThzOHE2WG50OUVSNlltTVhGTGhUMFhndmcrNlV3REZpMWRRcTNMbTZBY3NT?=
 =?utf-8?B?VUV3Sm96YWFZTTduSy81eUl1dUlFUjkzeGVFSHo0ZVJGcTNVYXFQNnM0ODdm?=
 =?utf-8?B?UmxKcmpFaDBtdmRmMlVkcVFCWWxYYUIrOCtuMHg4cjZGM1d6bjkwajM1WnZG?=
 =?utf-8?B?b2FJTVlpdFVNSFRPZnJJbFNpQ1JmUlcxeW8zZVc4dU9yY1V5OWE2bjc4RzFK?=
 =?utf-8?B?cm5tL0NtNkgrc1BCa2IrUW9qejNxdDc5NXdBZThQcytKV3Jad0swdzJzQTdL?=
 =?utf-8?B?YmROY21PaGJPZHlWWFArK3ZqVVpFTDNhUWxqOHY3aVlxYThTVk5MZ2gzT2tR?=
 =?utf-8?B?NEdoaGZMRDZnU0Mzb1ZLSHo0NG56cDJTL1ZSV1RKV1VVazJIRzNFMVhIN1JI?=
 =?utf-8?B?KzI0MGZva0M2ZFhsNnJmSVZyaU9CalhSSDE5bVpodCszTTVCbkIvZ3lEQ1Ru?=
 =?utf-8?B?Y1ZjQzdoNGorSUgrdGNjeGltb3lHZ3dSQVhrN3lEbW9WdXYxMFBaM2hTQVdt?=
 =?utf-8?B?cFVLc2c4WG0rbU9NaVBRbU51cFQzR1l3bkg1d2F1VWlzdHoxQmkwUEdOR3JW?=
 =?utf-8?B?VVI1SUFTZnBXRyt4MUZvNHZRa0Z1Q1pJN1k4bEJneDZJSEs3ajBDcUhDNHhX?=
 =?utf-8?B?M3lrbkZYMkNNaFRBYTdONnd1Tk40YU1WYS9KVTRnRUxxblErTlZEaWd1bzI5?=
 =?utf-8?B?Z2Qxc0NVNDRKRWZiOHVtNXZYS2drRWcyRVNBZ3RTMEhzM1FMZTJHSXNPT0kv?=
 =?utf-8?B?VlFTS2VmSStCbHRRRytrYlp3TnNMWVU0WkVUMDdRQlhUdUxHOGE4ZDZoTzZI?=
 =?utf-8?B?azdxNllDOXlRMlJqTVNYa2I4WEVzQStkOHJvcXFIRi9mTnVqV2JoZWFNRkU0?=
 =?utf-8?B?ekpjZFRzL28zRGtWbzVWNE9BbWM0UWpCTGdVRExibFdseGx2NGozUmJnUE5X?=
 =?utf-8?B?MzlRWEdvRHkyZk54YWJWekJMSVVNK2x6T2N3aVV5bzg4dlJKYVYxN2N2WDRz?=
 =?utf-8?B?cWxyTk04NE5LRm15TGdHUEpxclYrUi9XRVI0VDJNaDJZa1ptcHVHbHZaWEV1?=
 =?utf-8?B?NklwZEJSQXptRGNoc3huRkg3QjZqVElzcHd3UC96c2hRSWZYYWxYMUdSUXJh?=
 =?utf-8?B?RU9lMzdSa3FGSytaZTJ1M2QzNnlGOTRMZnhGWkxXRUtYOUpSdDNxbldRY2NJ?=
 =?utf-8?B?ckV5R2ptY2lQb0plcThWSWpLMGJ6R3JJdEdzTXZBTmhxZ1JXTUphNlh5WVdo?=
 =?utf-8?B?YjNqRnN3UEF4allwNEVIRHcyc3BUcVBOTDl0a1I4SnpxSk5Vdm0vWlh4SGF4?=
 =?utf-8?B?TXpmbUhrNklMRDMyWEludHhVOGxwM2FyTVE4dGhLRXE2TDBZZSs0YTdKYzhu?=
 =?utf-8?B?UU5KdUM4R1JxT3hWL0ltZEdRVFlFWXdKOThFYjhPRk9meThjd1BYUmRESHoy?=
 =?utf-8?B?MHk5KzFJNlArQ2s5M21mOVNhQ1RMa1FraEF1dFNic0tXbVVXcEtJbUhua1lB?=
 =?utf-8?B?R0lPSC93SG9jNUJMUmhZeXlRbmI3U295aDVnUkh4d3NCM1o4WVpVMlEzUWpN?=
 =?utf-8?B?RmNLcWlvaldSU3pmRFBTYVBlTTVZQTNWeEwzUDZYVVcrUDQ0TXlTVG5XM2dF?=
 =?utf-8?B?amxnS2V6WHF3d0JseEhFM25EQmlkMnViZGlOVUkrbS9IL2JVMnNVaG5pNUVU?=
 =?utf-8?B?ZE9Qdnh5cmlqdFYvNGtFN3VxZTNQNy9lQkxSS041a0l2MTN6U2ZqK3F2ZW5D?=
 =?utf-8?Q?QPK24cboVtzfDwI/62MnQZb/hZX1v6DypBZ/uvD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDY0VlpvS0hRZFdEaU40WGwzSnlIZHUzV1IrYUZJSTFkeUhQV00zM2JqVjJO?=
 =?utf-8?B?RzFZdUdGUXViSVJET0s4T0pBVy9nRFQrSWJoUzNkY1NXanlFdzZhbjhqQ1NO?=
 =?utf-8?B?NFRvVi9jeERjV2JBL2haTnVycVUrYWxMZjZKV1l6dXhTSVA1Uzg0bHN0aDNB?=
 =?utf-8?B?MUtydUdyYXo5R3pSUjh3UlV1eFFDYVVrcmQybXVvZ05oMkYvSkIxTEZxZDIr?=
 =?utf-8?B?OWs1YlJJVldlRzJqVFcxbW9rRlVzZGdzLzh0RVhzRnU0c3RWREhQdDQ4Tm5o?=
 =?utf-8?B?WTlvY2xSTisySzVGQi9TUmtpeFJBWDg1YzF6RTkrQzRpU2I1WDcvZTVmNjU2?=
 =?utf-8?B?S3c3QVQ5WENFUEpqV0xHNytXVzExWVFiekhXK3pha2RFRWpHb3RUTVg0MFdW?=
 =?utf-8?B?cWI0N2tzajlEaEtZbWFRWVVEU1QyWkt3MEZSb2tuc1RyekNpd3lhNDJIcmUx?=
 =?utf-8?B?WDh4eE44OEJTb0xrMitUQldpVkJiZkpHcW5SbXd3L2JBcTJ0OGJENXhtR1B6?=
 =?utf-8?B?MmNSeFNOcGxOVnZUV3lreTh5dmF5b1ZrSDBodDQyLzd4a2VYZ3FsNldJbHFW?=
 =?utf-8?B?NkFvTFZBY0NadzUyLzZCRDAzdCtFTUZUckRQamFOeTQ3Y2l4SjRMWVR6Mi9m?=
 =?utf-8?B?S0NMWlBya09ZK1RsM1drRms5c0djTEdPVDBvZVRybWgyN1hwOGlNOUg0WTc2?=
 =?utf-8?B?cjVUZ3k3TTRwUzdyTWZ2QUxCenF0L2pMbjlITTFXRDdLVlZ5Y3BRRmhXREgw?=
 =?utf-8?B?M2swemNWS2swbGtJcEE5UU5zMmJwbUt3U3lKMkJjalZHbElROFNPazRkN0py?=
 =?utf-8?B?S1ZFdTc5N2JCZm5hQm04OERkWnNnSGUya3BDT0EwODczT1B3dXBQaVI2U2pw?=
 =?utf-8?B?UHJkSjJjSFBjcnNZelQ0OWpabnE4ZE1wcE9RWDY4Y21kbmI4eXp6czh4V3l0?=
 =?utf-8?B?ck55MTEyMTFhWGJmMnlDVmNVazhRRHYraEhoTUZNWmF1cVVFem53WmJRR1Ry?=
 =?utf-8?B?TFNrTjl0MGpZOTlVWFlSd2NtUm8rU2hjelQ5U0w3TkNMbEVlUERWWVoyL0wz?=
 =?utf-8?B?SjJ0blJyK1RCaE9lZlRRb00zWDUybkVURXYvZmw5TFd5bzMyZXZsUFFLTldi?=
 =?utf-8?B?TFRBUWtKZS9ydnVod05BaG9tS2tLMTFSUGxXNzZLN05pVDdZbnVjZ1o0bVlP?=
 =?utf-8?B?S0RJenJ6N2xtZ09EY1RsdXp6RHFQeUZMUlhxWndLTTRMb2hZdExTNUhlcnE1?=
 =?utf-8?B?TEUvYW0yZHVTcDNZcDR5RFZBcU1QWkxLRHhDaDJEc05rbkxKU0pOcTlnNXh1?=
 =?utf-8?B?a29XS080blV2dXNCeG1qNnBHMFQrTDM1TEdBQU5PR3RETFNnRTVERGxtNGNU?=
 =?utf-8?B?NFcyTk0rc0NaOXJ5V3cxV3pad0NsTFJzQnRsNnJxZUlGbE1lL1Rsa3BBVkF4?=
 =?utf-8?B?RkFmd29EZU9jSGw4Y1UvOG9rSXBjM3c4MCtNcGdRMlJ2TGE5azQvM2wxN0kx?=
 =?utf-8?B?M2QzS1pHZHQyY0w5NTRJUk5aYmg5dXVOS2tKUHpKRnNaRGdYYk1BRUp5eDNv?=
 =?utf-8?B?Y3NJVERmak1USGJWcXlwbUFxdUdxdlVxckJQWkYzalA1cFdFR0hSc3Vuc1dJ?=
 =?utf-8?B?eDE3Z2tlYVBnZ2RoYzAvZGo1SmE4VDdkV3MxR1JTcGtWa0RiMDg5K0kvYVNy?=
 =?utf-8?B?L0JLQWJzSHZGZUMyTzNVT2thUzA3ZVlycDdZaTJSeTJGYTZYbzFKUDNTM0Jq?=
 =?utf-8?B?c1BiQUFSRzlEeGNHS3RQNjBNUVhFNzJtUm9pcDIyZlBGNjFLclZkOExBREZq?=
 =?utf-8?B?dE53MVRiQlBUaElCSmw4a3FOaStrTHZzMkZxQXVxcGpoUGdnem1BM0NPVXJM?=
 =?utf-8?B?KzZCRUlOS2o3WG5VWjdoZ0JtQWxHR0ljREtxa0orNFNaeWRoNmluazJEd2pD?=
 =?utf-8?B?K1pPNXdrdHJBck9VenRMei9uMlFlK2FsM3NsMjgzTGlLaStKR00zbEozeXZz?=
 =?utf-8?B?WnJJR3pSR2Fzb1Z5LzBEVUQ1ZDJ1S0ZiQm5pSlJJK0lOeTRJb3ZocGJwUlhX?=
 =?utf-8?B?VkNaMlhLQlBtci9ndGhrbnY2WEhwcGs3a3hZdnlzMDVXRFQ3SDZuenFCNVNo?=
 =?utf-8?B?UmF2VnZRTitxQ3V6eDV0UlpFOUpEYVBsUkt3eG9kN05rcDNzZlk0V3VrSnRz?=
 =?utf-8?B?MndEL2Jqa3hJYzBjVmpOVTNXWHR4K3RvTzc1NnE2ZUNtOXNxend4eUYzdzRa?=
 =?utf-8?B?TWVXT3Nod2VTRi91QVBKbGh6TFpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7a4d0a-45cb-4ca1-3e8f-08dc8f6e2696
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 08:10:43.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8J6fzgARLpjsWK2HWVhBE5mULDmKznW5otIXFLYA4si3poZhlr250RYoo12OcQp9liY+BIWJKymWDkJ0L62o6qa3pw+/Sy6Dd0WQinCGoZndIx/QUWQAZ5ENdyq+fPJw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11622

SGVsbG8gTWFuaXZhbm5hbiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyENCg0KPiBGcm9t
OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTgsIDIwMjQgNDow
OSBQTQ0KPiANCj4gT24gVHVlLCBKdW4gMTEsIDIwMjQgYXQgMDk6NTA6NTZQTSArMDkwMCwgWW9z
aGloaXJvIFNoaW1vZGEgd3JvdGU6DQo8c25pcD4NCj4gPiBAQCAtMjIxLDYgKzI1NywxMCBAQCBz
dGF0aWMgdm9pZCByY2FyX2dlbjRfcGNpZV91bnByZXBhcmUoc3RydWN0IHJjYXJfZ2VuNF9wY2ll
ICpyY2FyKQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgcmNhcl9nZW40X3BjaWVfZ2V0X3Jlc291cmNl
cyhzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIpDQo+ID4gIHsNCj4gPiArCXJjYXItPnBoeV9i
YXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShyY2FyLT5wZGV2LCAi
cGh5Iik7DQo+ID4gKwlpZiAoSVNfRVJSKHJjYXItPnBoeV9iYXNlKSkNCj4gPiArCQlyZXR1cm4g
UFRSX0VSUihyY2FyLT5waHlfYmFzZSk7DQo+ID4gKw0KPiANCj4gSSBmYWlsZWQgdG8gc3BvdCB0
aGlzIGluIGVhcmxpZXIgcmV2aWV3cy4gU2luY2UgdGhpcyAncGh5JyByZWdpb24gaXMgb25seQ0K
PiBhcHBsaWNhYmxlIGZvciByOGE3NzlnMCwgd291bGRuJ3QgdGhpcyBmYWlsIG9uIG90aGVyIHBs
YXRmb3Jtcz8NCg0KVGhpcyB3aWxsIG5vdCBmYWlsIG9uIG90aGVyIHBsYXRmb3JtcyBiZWNhdXNl
IHRoZSBkdHNpIGZpbGUgb2YgdGhlIG90aGVyIHBsYXRmb3JtIChyOGE3NzlmMC5kdHNpKQ0KYWxy
ZWFkeSBoYXMgdGhlICdwaHknIHJlZ2lvbiBpbiB0aGUgZmlyc3QgY29tbWl0IHdoaWNoIEkgYWRk
ZWQgUENJZSBub2RlczoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvYXJjaC9hcm02NC9ib290L2R0cy9yZW5l
c2FzL3I4YTc3OWYwLmR0c2k/aD12Ni4xMC1yYzQmaWQ9MTgzYTcwOWQzNzE5ZTVjOTkxOWE2ZjEy
Yzg2YzBhM2UwODhiNzEyZA0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=

