Return-Path: <linux-pci+bounces-44077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB1CF6645
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 02:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C8A30443FA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 01:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8621E08D;
	Tue,  6 Jan 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SjMP8AxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79F2192F9;
	Tue,  6 Jan 2026 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664382; cv=fail; b=iEayAJtWkqw7g7z4lcJz0jgwIXMKBaoUnP63KkiMCZaua8iE5gNjv++y8H/ZJDkMI2b6SXhNffJjji1FFvwUvC3KMglvtSFqoe0NE+aMHWOtifuraj3AJ7TSESD+jvm0rmLAQe8o3wOgRPmJuwN0mLB4G16HOPQlAhFsO7AKmC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664382; c=relaxed/simple;
	bh=XzcHQUI2OM1OtJ6dKkFyiKwM1Ku09VK4deEAPu1165k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=umCl8iBYLECqtJkCuxX9JlRREUOCzmLNLlThVpwFGW8h2xsL2Fr2QSCL5v+OcNvnc67FkZGPGhebMrmUwCWs4LBJgwLNqt8sJOwCEAyGHQv8YYMBUxLBdvZS+JL5VnkCN4+Mwt5k7FgtbrKCxgUi1tmnswLbdON7CxYnN1Ni8t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SjMP8AxI; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrkyRcSl0GraG+Jtn4MBapx84XHVO1aXvjfcidiC2qyYchUUkWXZh79ndZYTtchf3iWZY63Q7vQcVveMFvj9a3dSjmvEjDcFyXmwm7Z0IIaRGgwNbC/Mu9+PC0LE3jhGBiFp08CHNm6InMhBvJLLDy8MphuuyUSzliTVCIG6l6lR/lyfI81Wb8UQFL0jmoQYvMuzR4o+kVUsyaBU4g5hWr8iChdIerc+jYN/AbGedzP+Oyzpym0Xt/O+/Mw426OmepZ/WGIRV0fkTafzG97KXn/Ac5r1tmC7Idi4s74CmEfgPkG8bHlvtL563XlubyHPRPFHK6A3LXzFUKh9/WVKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx/0+hkgyymwYGa7EriBdBsSzoIjvTL/Eok96kLybTg=;
 b=AyEsSmUiSHuh3EZveKzj0oDq0WV5Rnv4JURIjqPt71T3JVS4rPmeoSdjgixzNxGsjiHTP+idbCpO/RgOt2cIeJkD9Ri0PrpWGpgY+gpw7s3XMQRtFGueh6BseikmLnFH+QlFl4AmwnIi+WvFz09EYpmUchZLtWP52/+k5+6CS6lEIrvmaHhzvUDssVEflxseLLSLoxcc1znNlHImpYTeS48Vd3DjMW2aKhb1ChOYzuO3A2cLXKHHTeNeCNtDyRpfAi37GOQXF6NaUhdF0Lcc2cDkLjhov4AiBV1zIDRL4VN1QIrtgtG2VBEMjwTedx+1Qp0fqup04HBudD8p6/Txmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx/0+hkgyymwYGa7EriBdBsSzoIjvTL/Eok96kLybTg=;
 b=SjMP8AxI4qx7kdKw4ivaxyiTVDPy4Q/beTLXSzw6RnjVBWosad7obuIqaBHu3ASyeGzBsGj2q71UE14ELkHlUF0lv1kAJCqt2d4PZeuRrXJbwMfv0UrL92zxQA3AC2EkNSEG3NLc1+kj85EswZVhMo5ZYphm+3vqXZkCVYqvMuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4580.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:193::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 01:52:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 01:52:56 +0000
Date: Tue, 6 Jan 2026 10:52:54 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Message-ID: <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>
References: <20260105080214.1254325-1-den@valinux.co.jp>
 <aVvtAkEcg6Qg7K3C@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVvtAkEcg6Qg7K3C@ryzen>
X-ClientProxiedBy: TYCP286CA0238.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6feea9cd-8164-45d1-8de0-08de4cc6500e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWEHIsjyUbDWVKTHBekoaXlsxJmiBrFP92MhBXVhW9Xyi5LzeRl4pY8kxrjY?=
 =?us-ascii?Q?Marm0BCZvvxUiSx37rHjUIHb9n86vAhruD7LftkWuelG/97TjtmY7lp8/izl?=
 =?us-ascii?Q?gWZe6JulDwHslsjAc+itNabe/pukISrRTGyucngKwf6CpFVszrXTMDod4+ah?=
 =?us-ascii?Q?S5bxYjNn/CufQC0gJYA2Oh2Rfdq0Fm/nfjRT1fVQroaR2ScFQwhzDjzUYAsF?=
 =?us-ascii?Q?2jeN0YHWhymKtMl6Toi2LKOPLesLZQHkNObRPIJHM5WEtTCHqfQgqn/hj260?=
 =?us-ascii?Q?FeimOXx3f6rBXtKHf7582DoMWphqNI+caDI3kxnY/ylLWq0DTeDA6YrVriCX?=
 =?us-ascii?Q?zGhRHZHycAN0BLDqaWUt/PlQ0jUO+njr8EW9VzsDwAULfF8uljrvjfK+wQfv?=
 =?us-ascii?Q?DW9yfE4+739i28GG+sKQiSNhAbpdYAKllfQjZ5AVFAePoBmribsNfuTdiWqp?=
 =?us-ascii?Q?WpuUv0xoRw0nT7Tm4z+3KlKlnXVL1rh6lFO2SdNi5UGwGuGijhJGMoiJhgEq?=
 =?us-ascii?Q?xCPBK94f81imB+AaFHtBL/qFQLmrXQYPkUqML2NZ816Gln10WPebbwQPg/7k?=
 =?us-ascii?Q?fgf9Gf7HyqZzai7mnV9n5LlDwlcLfLRiKkDkyXX3Uu+1kcF2vUdeFlF2nfrY?=
 =?us-ascii?Q?fgQp+BSoeLgU/u36l2mHCfef1iy+IX9F8++gm8Ok/RPqD8S3dIN7V3J6Lnss?=
 =?us-ascii?Q?pztBfw1nW6bhGvSjPirveeD9Pd3/Hw815maAlkLqKeYBUQ9lYjDXTkGaOmFC?=
 =?us-ascii?Q?0Cy2NzDMheEwkwDEtJWSUOXTluClOtTTYS6Eg9UcqA/+fZy0VM4NJRwsvYbF?=
 =?us-ascii?Q?BFfkeabkGvJd0OW94xiZdHIWgewz3lbrJK7QOa7JZEMszdXnlJl7d+J/34EH?=
 =?us-ascii?Q?ndkbwZOgDlkkIIA5GIHhTgsYEzvgY9y/azW0A1Fu9SSQhaFqk4g1FMk884RR?=
 =?us-ascii?Q?kstmVE4Bm52/ioswQYvIFKwCk5Rjvd3UtC4VBf/N50q4baX6QCqv6iIXb7RM?=
 =?us-ascii?Q?oT1EucKsUWTkfi9DBLzB7hi2YMajqQS9CRQDV/qH0e6oZpenNxxk5J+H5KCB?=
 =?us-ascii?Q?zmMS/c5Qk//5ZePfsPiMWexTB1y+v9R2S74pXfSFutqp0BkknEX1hm90lgQw?=
 =?us-ascii?Q?ztW+NTJfi8ViC32aSD6Jt0D90cQVsK2YNjSKKNZ+e4Ru1NQHloi9Tb9mJjvu?=
 =?us-ascii?Q?1E+WljDSoHV6dRltM2UA/SZfQNyt7hmhOi7Dt2kq7DxfYHaCIHeqKOVdBbV1?=
 =?us-ascii?Q?+VhUuTMsx/AFR2jbTlzH+mqdYxHPJMhXvsSxn9/oH7OLvjJ23Clse/CVAWMK?=
 =?us-ascii?Q?axDcLMqC5qOYVFnTt5mBZYTmdu6gCuScrhjpxGtjLMZzjP80EKowoGOGIs2e?=
 =?us-ascii?Q?Bn3YzmjnO9pfDX3BFP7XAoagSHb1MfdSrLRao+CQSeYEi8Edjo3BObMDVTtU?=
 =?us-ascii?Q?U9ApYOBWCNI44S/1xPNPYkORZTMxVlMtVLWJwbPJQzmcqkhqDixPYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aLeZZmcqf6V0FAFpQR3uOh6mD/E1MwIc2P+wOxsaGFP8pK76/N+VYhXJPLg+?=
 =?us-ascii?Q?lzOs3sdr8Jk8R4EbSGwCYnim7eDkJYbYF9X72JuuzuZG/V3IcDC0EfNp9GXy?=
 =?us-ascii?Q?OVEY3IcpIOyw3dlWjiUH9nVxTVdV/Hr/x1h/BfmKLu8hIBxyhdEG5QOLvHai?=
 =?us-ascii?Q?GSpTdOx2Gq3JsFNZfmrT/IbdD/UmSDzC8ggTY/lKr7eZ1P3gTc7RqPAmi5Ke?=
 =?us-ascii?Q?GyemGYItiNO/SShKdq4y+JIHUHY5xS4wBN3VBASxoEUa58azNVjJgZUGCyRI?=
 =?us-ascii?Q?MzFmLuSPNHPlOhM25wTJI2nMrRzJVKrAwR4Mdyp8HpfpgYGiCTjdRj0c3u5g?=
 =?us-ascii?Q?gNxc7AHhxUzlmHPsocFJqtJ2J9BXJbsp3XGXa8Py1e2kS//BnI7oAgBSZKyc?=
 =?us-ascii?Q?ZKfCi+g6+xULMj8u8aRi4OP/oWY+zY2nDH+XSLSZG2QUk4sAbsQ6hp4uMT3W?=
 =?us-ascii?Q?AmNoJBhbIxawEbFBiH4bINMLh/K1gYTsdS4oB15HpjVANDb/uHLOiT3g0SuB?=
 =?us-ascii?Q?GIrXRo79gB5B9sKtRvAFD+OpwLizOIxJ7FEEhmbELxo+1b8xHLOpHoIGWx3O?=
 =?us-ascii?Q?fVyRziyPNdwZYnl+dKzbsx2kR/n0ohlFD+VvVkijOAAH/sy74dzRe3SBTckO?=
 =?us-ascii?Q?NY0yRbG1YOW3aVHGBGP9y2Rf3spLAKgb271m1KXF/8aeKZlU/UIDhhwMDXfV?=
 =?us-ascii?Q?wFrEQ7XAnq6ZgPidvj/4nbHbbfjNDnMYko0tIoZbZZ6TPh5CbGNqSE/fewBR?=
 =?us-ascii?Q?aZSju10rhb/pnZXCY0b4iKYKaImRlH7ydaSaVn38Wc1Q35vrQDH9Tr3cOr25?=
 =?us-ascii?Q?iJoONf5pYQ5owYWTYOvTOqkAhcVKjT7CKxX3y7OK7X7iH5DZIlf5+jyvcE9U?=
 =?us-ascii?Q?zKF9qyAazb7ANiTRkOx7g4WdToMjR/w3IRwMOlitWJjz7pU07bGuo6DR/5mA?=
 =?us-ascii?Q?DjEANwrYkmEx3Fj9wV9mqsdke2d9bACgqPdB2bVNR7BgWNSq0y9HuiIQf9ln?=
 =?us-ascii?Q?Mhuz6md/XiIRRZEYhdvfR171A09B/X27GvnrUeYQgTr1A0bd+hyEKO136qFH?=
 =?us-ascii?Q?wjIk8fJrIZKzdW8y0nVLm95wznev9+7AHIBdIYGGKIFjscTO4u2sBt5SrYup?=
 =?us-ascii?Q?7Og/vdaXTUoqAHlutBWQAbU3H01zePAgySfGQxJGlKCFYV90ldJFntU5q/kZ?=
 =?us-ascii?Q?RaE3qwrnGAUWvJQFsFjmNI4Fk6gGyPyA5SiGR5ver6iWU6aHC1F40uUwXega?=
 =?us-ascii?Q?j+a0AB9ghaWnJFrVoe+ZzYg/5Iy6AFrxwdSTT3VN1eBV/U5DFxEVI2bS4+h7?=
 =?us-ascii?Q?gjb7Q8QWcGOyMGyBQZtD62t+Na/7tIbj/kzA7wn9bDB7wYr2fJ85Oc40qxsR?=
 =?us-ascii?Q?0pVHCczYXv2UEnKttuG+aNCXOImg/YwFfxNvzFiDv7cW/fRFFHPhKi6cpBim?=
 =?us-ascii?Q?gXtINyPyaJEcNtAfVwuGBC37hW92C+sC1np16QnQbWIOmVL0JShS1e4QQtmO?=
 =?us-ascii?Q?EdYid9rHUu+lfhwsWnp9Q58aQbHVi/nli1gVAbD28Xp8xjMS0DGl4ZwfPezJ?=
 =?us-ascii?Q?NSHydp8/xJ2nTJd/fCSTLS05gGytiSlOWoIL0eG8bapYcWhpvDhNOWyzrUQT?=
 =?us-ascii?Q?AyKXVHKOZLFqSFKo6Y+TkQqEcE5V65nSkxZoP7UisF7FmIME79Q4jKCr0sp0?=
 =?us-ascii?Q?0jjgXVnO6Egu85seZvwrc3uQ9PmbSCS4RitnsIzRbTWMM8OdB6s/AcG4XG1i?=
 =?us-ascii?Q?FHYrms273qbqv+UU9JLcRP5MCNzwHsjcnaaV0Qj7C7O+fdlVkBCB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feea9cd-8164-45d1-8de0-08de4cc6500e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 01:52:56.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm/oQaAvN3TuWydYpgKSvYbVUS1xlEvYEt3mYV9bAkLn/VtDozYLhFMYN6zkBnfb41tqWoU1G1vpQ3ITsDsXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4580

On Mon, Jan 05, 2026 at 05:55:30PM +0100, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Mon, Jan 05, 2026 at 05:02:12PM +0900, Koichiro Den wrote:
> > This series proposes support for mapping subranges within a PCIe endpoint
> > BAR and enables controllers to program inbound address translation for
> > those subranges.
> > 
> > The first patch introduces generic BAR subrange mapping support in the
> > PCI endpoint core. The second patch adds an implementation for the
> > DesignWare PCIe endpoint controller using Address Match Mode IB iATU.
> > 
> > This series is a spin-off from a larger RFC series posted earlier:
> > https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
> > 
> > Base:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> >   branch: controller/dwc
> >   commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
> >                          to support 32-bit MSI devices")
> > 
> > Thank you for reviewing,
> > 
> > Koichiro Den (2):
> >   PCI: endpoint: Add BAR subrange mapping support
> >   PCI: dwc: ep: Support BAR subrange inbound mapping via address-match
> >     iATU
> 
> I have nothing against this feature, but the big question here is:
> where is the user?
> 
> Usually, we don't add a new feature without having a single user of said
> feature.
> 

The first user will likely be Remote eDMA-backed NTB transport. An RFC
series,
https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
referenced in the cover letter relies on Address Match Mode support.
In that sense, this split series is prerequisite work, and if this gets
acked, I will post another patch series that utilizes this in the NTB code.

At least for Renesas R-Car S4, where 64-bit BAR0/BAR2 and 32-bit BAR4 are
available, exposing the eDMA regsister and LL regions to the host requires
at least two mappings (one for register and another for a contiguous LL
memory). Address Match Mode allows a flexible and extensible layout for the
required regions.

> 
> One thing that I would like to see though:
> stricter verification of the pci_epf_bar_submap array.
> 
> For DWC, we know that the minimum size that an iATU can map is stored in:
> (struct dw_pcie *pci) pci->region_align.
> 
> Thus, each element in the pci_epf_bar_submap array has to have a size that
> is a multiple of pci->region_align.
> 
> I don't see that you ever verify this anywhere.

I missed it, will add the check.

> 
> You should also verify that the sum of all the sizes in the pci_epf_bar_submap
> array adds up to exactly pci_epf_bar->size.

I didn't think this was a requirement. I experimented with it just now, and
seems to me that no harm is caused even if the sum of the submap sizes is
less than the BAR size. Could you point me to any description of this
requirement in the databook if available?

> 
> Also, we currently have code in dw_pcie_prog_inbound_atu() that verifies
> that the physical memory address is aligned to the size of the BAR, as that
> is a requirement in BAR match mode, see:
> 129f6af747b2 ("PCI: dwc: ep: Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()")
> 
> This is not a requirement in address match mode, so you probably don't
> want to do that check in address match mode.
> (You will want to keep the check that the physical memory address is
> aligned to pci->region_align though.)

With this series, the call graph would change as follows:

  -> dw_pcie_ep_set_bar()
     # For BAR Match Mode:
     -> dw_pcie_ep_ib_atu_bar()
        -> dw_pcie_prog_ep_inbound_atu()
     # For Address Match Mode:
     -> dw_pcie_ep_ib_atu_addr()
        -> dw_pcie_prog_inbound_atu()

and the size check that was introduced in the commit 129f6af747b2 should
not run for Address Match Mode in any case.

Thank you for the review!
Koichiro

> 
> 
> Kind regards,
> Niklas

