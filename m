Return-Path: <linux-pci+bounces-15290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301C9B02AE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B723F1C20843
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03C1F7552;
	Fri, 25 Oct 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sbf7Obr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269771F7550;
	Fri, 25 Oct 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860203; cv=fail; b=R7uixfXsbnbhXtOOsyfAC09o8Z7hRxcss3AagrEvT1/xgCOxaqbFPT1a/7yF1vrQ9MXdPysB0dn9kqrHP65Trc8Av4LmGoyEXYmID9G8lBejQf/EIzpRN0oC9+NstBXU1Ji4AsyZgiyv7DQkPeDKIpVKtbigzcIMe/tczkGdx+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860203; c=relaxed/simple;
	bh=8FVzKoMyE64A16g2xzkdka8aYu2tbTdmeJ8c/vGTd10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AhhNI/lHlKDvbY1xgVRYB0r+EeUIRUmOJLB04oqG+rgRySRMDVewBkeKp9uyDqbJhmkAlbgkEdg1UPhUl4UyQxZXJ/1nqrli9o0kLy2CYtNb7R1OnpvkCm5WShbseOfIW2YJg3+EpQANpH3961orlUhEVA+5KE+CZHU117OTr+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sbf7Obr8 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkFOlxcbdElEtSddoMNovrxzxNxXudpF82Z2UPxWFW/yNbfqnHRz5htU9hyf+dNuyA3pe3ohMoAHQHi/Qsc0UWvUjrl74vxv//1aZghgdLWkXOnLJa8VQQaqIoyoqJ0lCmK4I1jw3CZR4e7jozvgA8QTVGof6DsFjtrcDJoKUVupiJo2MTRwwWQulEC/JTJke5MtbWkIaHxC5mB484CSxGdpnDY9vTMDVf9ufeEG/lZUHXlCs/+UcQPgID3fm8lQvf1SsefbEXeuisxPYSMYH8ajKyLVD1NlRvbxF6SAX2C1JglTLfOkssrXQ+mWsNz0teT2DpQ24YPSH4EoxWmB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gslRwVmSciaHGl9h5uCGvI13aOcw7lSC/U+IvyXW3ZY=;
 b=GwHuNXGbrAWkKXu4AiSaDOhCzQTr2g9iFV8Ye8KKDOJwWPdps1Nt7vP48hd+J3BfQJoYmmGexBMbH7SW7LCdRs7zIQ3gYDC+JE3Ll7LEquUf7+d6/0NE4HIm2sfRXDj/i4VkM28YaZ4ic7gDvdldKPmOa12xB7hD2KA8flnjIoI9sftZW/KVL+AdjFeJy4LjGGXFn7WN1I8CIROnqH5QoAsnWIJt4bLY9dR44iAvRuS15ZkRmO11SL7WT5Sox4H8ITwPNTZyF+h/W1JYct15mVoPAGoCnytpF3W330MCe5NAQoGCdtRC/UcVSKxCt+1xrg866ltpn44Am2ZHNw4d5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gslRwVmSciaHGl9h5uCGvI13aOcw7lSC/U+IvyXW3ZY=;
 b=Sbf7Obr8ynaVLlsuouf2qmo0M8ZoblBr5KGBDwTyHJkh2dgD/FiCwyYwR3ZXuzUYW5dvTCGcKH+3HaQlMlNkdpp+9tT3CUHHQ25DnD9SJirw342rvmYSwEA9egN/23EETMNNix2E9CdIPV93loQS10PmOAtwUA29qE5lresP+oes1G5zxv10pUFBRLc2OqSNEGunRoYoOn8cF5/lAJyTFm1C5x0qx57Uf9xG+EDwwDFZOC7aQZ1LHON16Np8Zv2xkaflDZoQ0GQk4CMOBXn6wLtVBzXB+JlK7+ZI1VmcR4T3bFY3kHGFJ6lW2wB0itEy6d+FCk9B/4ByutBNy0vsFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7488.eurprd04.prod.outlook.com (2603:10a6:800:1b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 12:43:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:43:18 +0000
Date: Fri, 25 Oct 2024 15:43:14 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v5 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Message-ID: <20241025124314.5hmsedlguacbyyjc@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-5-wei.fang@nxp.com>
 <20241024162710.ia64w7zchbzn3tji@skbuf>
 <PAXPR04MB851014063D11AC2C668C9B2C884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB851014063D11AC2C668C9B2C884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a001cfb-c959-4045-90a1-08dcf4f299d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?1qIaw9PNTTGCDMpOH54Dn8KC1hERCKen/0JSymnlPGEnc2z0ankoP+Rb7A?=
 =?iso-8859-1?Q?O89t+ENMopKVPxjKxN6BTfdeLLD9RyO6OFH/JOzqAuNtkj9TohAlQY8h0N?=
 =?iso-8859-1?Q?Anj1X2dswIKLsh9KanqYqfBZMJXHvEqy8AgQutqVdPfgJ11u4RnfUpmj8k?=
 =?iso-8859-1?Q?/kIQp5RGRcoof7Pl+uG+bX5Z4G/i0H/T5kwRHd5cn1TMSRLPqkiBdIupo2?=
 =?iso-8859-1?Q?en3cNCKyzzp+Q7P08XX/NZDdqY/Jn/7P/Jlj5QvJtxrQNH1Tx3pmENIPRX?=
 =?iso-8859-1?Q?OGPCW38mpqFCTk9F1Br02sl9OFj52YSf+zw4XbmZ1Gtlg3ndgMIvo2b2H+?=
 =?iso-8859-1?Q?VeI6p1oWO93IHyQKreGZO5tD9lKwoQT5dcju1BEgENZpNHOrgeCXMqpcjR?=
 =?iso-8859-1?Q?tamWSg9UQBCUnapQLTOv61SgOGIzLcpx3KaGcjAI9tcTn2tzuU15Cy3mem?=
 =?iso-8859-1?Q?HZJJjnu2/c9shL9xQXq5Uzrk2zvoTbWUiiyqHqWYE1u8m6sM7dABksL5tf?=
 =?iso-8859-1?Q?11zOm443B8WCiMWKCB457QiSschpC/1b/RXFq3/i2DhEpKHazZFNVCLW6c?=
 =?iso-8859-1?Q?GbHBfANWvTu2+9xifYF9t1C6DVNGbsE23iNBmSTaM0/8Jb416C5UOnv+qh?=
 =?iso-8859-1?Q?bzzUwJRhlD4UHgJQHY2D9mOfqVk3E0U2Q2VEOW72NyPrK4xL3eBN1Ntoii?=
 =?iso-8859-1?Q?+RXpfbhjH8+N7lD5kgoWX7XcB60VURZx92bc1aSs/GYFkcdO40Ve14zDMu?=
 =?iso-8859-1?Q?69VPjW6aETs7t4wTh6ab2XudgLbqEGG16iGgtGumAZP3izuoapHtmHSuJU?=
 =?iso-8859-1?Q?9l4fCae7V1hSmz7lhPLYmEWXZ7B6WTyVbncAcMuNeSDUC+3Yv7U48xFWVw?=
 =?iso-8859-1?Q?Q60uNATInGEc6RqgTbacFRl1zy18HpGy7+ABave9n0huWj7CONiG4QiCSD?=
 =?iso-8859-1?Q?O/qlYxTikVaF2izOZYScGuW6P00Mx5tIXvixjaFHFZ60ipj6YLjnK/UuOx?=
 =?iso-8859-1?Q?w16iS41LRNFZOjg7x0YMwK26l1icLrroHb5VITNOnhFqagEteLvtWMy65L?=
 =?iso-8859-1?Q?f6+wOqD5LUjK4wZUXQT0HRvQW1c8v7zAsebcdjeaWUMc43eFGuiY+ibfyD?=
 =?iso-8859-1?Q?pfhqSA7LHk5Dd4Ns20eHzY/vSSmbeWZovIJCdnk/guzWdJJ6j6IqZwCdL3?=
 =?iso-8859-1?Q?SVi4CZMI9DtUt9uBqfKDBR9xzhJvcTxtKIBeiNk4rTdyOvdZv/IqF8Mdqh?=
 =?iso-8859-1?Q?pluPPhz7EYVpEeqGulcX/qxob/jeKe4tc82DcQdf2LEa022niTg1Etq7P4?=
 =?iso-8859-1?Q?av7sG1h5NLZZ8Hh5vDsbKZ0F47IMxUyAgb3y7ZxAMJkmM0ZnmGIOxMHgNx?=
 =?iso-8859-1?Q?MfI8f8PWxy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?NX/0ABSWpjnFrw5kmO1+4AeVtr0J5leOs2zfrpQl3SgCxrCgB122fDR4Pq?=
 =?iso-8859-1?Q?730gLPvC4Epwl2FR5L0ZdaaHwNB9oQU+uaKhFvBiaorH4WpG553J530Ynd?=
 =?iso-8859-1?Q?HMuHPBwAV9FCV4Vg0pny3kQFk6ApKKlS+fexe6tbVzR474I5Q3wv1kngP/?=
 =?iso-8859-1?Q?VvQPWkOcICjqA5bRi4OobkNTF521q1xUCnjx7SXow95F5+NZO90X8kqLAf?=
 =?iso-8859-1?Q?ruYlfm76ScsgB+Ez6DZjABpPeu3EJROXADRreHUUPm/byCrhO/WgOqsvGF?=
 =?iso-8859-1?Q?zoo0bqggsY2vRoYtCBVYutbs2ywzaeyA/sJml69EarwtBz9p+NSsooKHOV?=
 =?iso-8859-1?Q?GsbPcFHo+vMs9SrMpO1Iftexbh/ADhRA28mntqgzpgnxD159smmsoepqhE?=
 =?iso-8859-1?Q?qelrPkD9d9yqBrDd8ytYL7gdTi+J7feQxVbPcCn6aXQWWaLubkEj5es/zx?=
 =?iso-8859-1?Q?SoMgGdcz7WlzALWY7AMaBtJoOLwbciOKVhnaIfLAJKI/o4ZJzFiXZHrqSb?=
 =?iso-8859-1?Q?TFi/ePrAeW+NTgalFbK02GdiXomE4IuhdddiKpFITuiVu/n/AY2xGjRs9P?=
 =?iso-8859-1?Q?hie5RTeGrEHgMt8t33/H1b/2c/b/9KL4fZMcT3WyVnqgk6Z81Z1f/z27Lo?=
 =?iso-8859-1?Q?YZECEKf0swDWEQRIm2vaCi+zgg4JcjwjIO6hkDViFlZRTyeh7c0jYu4Vhs?=
 =?iso-8859-1?Q?DAkv+M8nNeakV/Us01Ydl6aKfwU/2zBQRPMqyO6Qij2qa1EI0e3R1dN/PI?=
 =?iso-8859-1?Q?ZOtkg2ZRJpePIEFD4eeD/kObf+hpsxoMOTmWyJn1qjLgqXuw9WEfzIuBkK?=
 =?iso-8859-1?Q?DF5YdJ/lZdHNdqYg/DpIsGDZCsHz895cBHSUn1Tr85meek6snQjeP6+p2V?=
 =?iso-8859-1?Q?0VaFIDZD0m9pH3eY5rLduxyxIIXKhpIVaX610LkvKywUkgnWEcEkDCVM11?=
 =?iso-8859-1?Q?Ekf0qvxB7TxiYI4lEf6jTO/Yw9gCyrnSfWNuFBxm4MuDEhg06hvRaONlRC?=
 =?iso-8859-1?Q?mHXc0hh+BgIXmhrujouUSRnggB1FYMz2XYmTPVepWtIpDEjTPyXDcTfhyS?=
 =?iso-8859-1?Q?teXabUPywz6T5D5C8RtIr1zbNwQQPRv8G88qG9JZSSSkutJEPA4CvjsPTy?=
 =?iso-8859-1?Q?rWtrXsmugpB7PKSAj/KB1yWSTi7tosmII1xepBCiLCe4kPywpG7pwdn8Kv?=
 =?iso-8859-1?Q?TIaA92YLQh17f+hCYi+jG79jBgaXnPFPpNuhytQjSbAxs3tlGNOd+W8++Q?=
 =?iso-8859-1?Q?mJhJzU9nqu4pRpr+X4n9hb8zskZcWkhmqMZ8YILM+g1emnIcLrebWlrMbp?=
 =?iso-8859-1?Q?AexyzPuFAzwg7+Urb3KSRox/grb6GCUkCbSweAIJJ+Jb+34cPyW7ukbdR3?=
 =?iso-8859-1?Q?idIOStUg+qIQk6PA6kkLLi+sKBvn6O2ZlwcWU26uy0nx1VEeqXXRgFqMOo?=
 =?iso-8859-1?Q?PpD+9D2wt50ls5dfXxR2rcJLArb5bOTMRk4RRCdY75nUwHNFiZCVskVeJM?=
 =?iso-8859-1?Q?u18OTn58dQ2kgeMAoMPu3ZiGtB7pelIeYMUJw+b8G84oT0PwyZkup9SaYZ?=
 =?iso-8859-1?Q?UWbJn0tQFCNrVJvW+5PQYMCeiRLAsVi4bjNIg3ZP+ZPiKXzSFGByn3fc3M?=
 =?iso-8859-1?Q?YY/gq6JRTxYPaV8hS3rH+r3OVkVrnP/EXT/liUGJuSeVSutcwKWcGdXg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a001cfb-c959-4045-90a1-08dcf4f299d5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:43:18.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwmqikVkDYAwNmQckPOMTsIEIEM2kbqDAcWGc0fJnlpM3O/qYd/5Dw1bZkmGCdGrKzTH+B5l9weLMjCWtFjUgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7488

On Fri, Oct 25, 2024 at 04:44:50AM +0300, Wei Fang wrote:
> > On Thu, Oct 24, 2024 at 02:53:19PM +0800, Wei Fang wrote:
> > Can U-Boot deal with the IERB/PRB configuration?
> > 
> > For LS1028A, the platform which initiated the IERB driver "trend", the situation
> > was a bit more complicated, as we realized the reset-time defaults aren't what
> > we need very late in the product life cycle, when customer boards already had
> > bootloaders and we didn't want to complicate their process to have to redeploy
> > in order to get access to such a basic feature as flow control. Though if we knew
> > it from day one, we would have put the IERB fixups in U-Boot.
> 
> The situation of i.MX95 is different from LS1028A, i.MX95 needs to support system
> suspend/resume feature. If the i.MX95 enters suspend mode, the NETC may
> power off (depends on user case), so IERB and PRB will be reset, in this case, we need
> to reconfigure the IERB & PRB, including NETCMIX.
> 
> > What is written in the IERB for MII/PCS protocols by default? I suppose there's
> > some other mechanism to preinitialize it with good values?
> 
> The MII/PCS protocols are set in NETCMIX not IERB, but the IERB will get these
> info from NETCMIX, I mean the hardware, not the software. The default values
> are all 0.

I am shocked that the NETCMIX/IERB blocks does not have a separate power
domain from the ENETC, to avoid powering them off, which loses the settings.
Please provide this explanation in the opening comments of this driver, it
is its entire "raison d'être".

