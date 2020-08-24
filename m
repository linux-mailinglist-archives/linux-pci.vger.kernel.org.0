Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDD2503C2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHXQup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 12:50:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44552 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgHXQte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 12:49:34 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C834740162;
        Mon, 24 Aug 2020 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1598287771; bh=pcD/wVWeFQDpVqmdx5pn2btRj0G+G1mD3pZlgu704B8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=T6eCnmsLDPKP05yau04JtFeWFbH+zUu6yyIVIgfm9p8/HdfJE99mdXn/ktCE94+Ll
         nbV42Zv6+fIUlY8WeAL+HEqTZXdBPvMO3WON3+joyVp9hgMILgk1p/la9Q3ZC4ORFD
         JFo9SqVLIrdc3Q/ufv523DidCGFfFq44rOrR2Ph7MxR1110K4OUqTh9/RajQByjngI
         Ctd5C5vskBH2JwoRETMto/P/8pXhYRb4hYYMJpAKa0fnAfFHBMIakdLKis1U7PVHy5
         dquaj+vhXZ2oV9kuab4Vxq9JEHOhCwEjTsgcGwikqyLUa3gW8gGC3CYfA822riA5he
         FsjAvzQfR90tg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4A31AA0060;
        Mon, 24 Aug 2020 16:49:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E583540107;
        Mon, 24 Aug 2020 16:49:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="cCPamY5Y";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0a6UE6tk/vlf2+npqiwTLDzqPBvKquEvBLPUCwoISFRjzqNsTNILYyVFn2Rr7wBDKQI4+6I3dmA1IzJNnN1mnf7kxAL5DncLkxywmN0iXMxcGwxc1CiFOhLL7DFIUCi5NRNg1sTX1DGaszTbhieFB4V3+WEHGSAv/tFVlZRs54m8e70fgiVlOuNytNovTJzIeh+rqoZxzBlKK9WzMaOQ7dm15JQXVNAxnA79NcEIdvH33Mna/dchlT0tBQHfEyG89dGo2626ODh1LsmCltO46bvz4gnlppzi0FQuHouLZhZzQ5UaNYJ3/gBNTjwJFq/CWnfm5YLofwLOCjiMuyRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOse11pPDXwBG2Qt04nhMntktYkrAZErRYgndqwfOPA=;
 b=MLcj51O7SSGrEvUEpAdu+PlqXXr9ChFvgP/DYrjEvtWqJ+exZGyg5dRjnGKwY/tTzwRGcYyWQFPQR/ayykus8dIawHHLJ9i0V01WbZUCrDrsF3kiB4WUwMotwc8+SDYNB46zecYST55KikvIPpd3PuK7xwwVhDeS/FRYJtjCeYd0nltcD/E86QkmTQRdJAaX2+AD1/q5mYhxjlOLrZtnosMNdBF7QM/zXQZnZVPhQ6kQTQc/OF6Mwl+j3cNCsXcZ6ciXDaHB1mGGPU1FMbYoITWuqJvdng5vc4OQzYPsizmhzhPpeJxmych5Fq7aRqn/lEZjO0sYkMwfv8jAQAjwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOse11pPDXwBG2Qt04nhMntktYkrAZErRYgndqwfOPA=;
 b=cCPamY5YHPe3stUGGUzbYDd7JEzGVVGuz2jukioIZ6vHI3Cq7TE77uUDbk40foX3zYdPEEOe4CZgsSSFhSVtWhzjkW+lFmIXBW45HuKGDJTD1MDTk5kSLMGqqLAtMTHgu68/NxCL0tFIt2kmyJ8oQIjkvd9Z/Ph4R/EiGyz4vlc=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR1201MB2522.namprd12.prod.outlook.com (2603:10b6:3:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Mon, 24 Aug 2020 16:49:28 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2d6d:2aab:cbcb:258c]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2d6d:2aab:cbcb:258c%10]) with mapi id 15.20.3305.026; Mon, 24 Aug
 2020 16:49:27 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH] PCI: Add #defines for max payload size options
Thread-Topic: [PATCH] PCI: Add #defines for max payload size options
Thread-Index: AQHWcXtJ00YvBwb3l0KUnO4AnVeUpKlBhq8AgAYCMaA=
Date:   Mon, 24 Aug 2020 16:49:27 +0000
Message-ID: <DM5PR12MB1276C8F286C45A96656A7A87DA560@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <3c9aea7c585171eefe40e0bec6e2b996ec894d84.1597327415.git.gustavo.pimentel@synopsys.com>
 <20200820205942.GA1566692@bjorn-Precision-5520>
In-Reply-To: <20200820205942.GA1566692@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWMzMjFhNDAzLWU2MjktMTFlYS05OGNiLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjMzIxYTQwNC1lNjI5LTExZWEtOThjYi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjIwNTkiIHQ9IjEzMjQyNzYxMzY0NDg2?=
 =?us-ascii?Q?OTE1NCIgaD0iRUNXd210NzhTVG5Ic2svSGVEeC94bnRvVUEwPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?aVRzR0ZObnJXQVVKb2xPSHFSWW5OUW1pVTRlcEZpYzBPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFOclNWM2dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.7.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2219fb0-cf44-4622-1151-08d8484daa48
x-ms-traffictypediagnostic: DM5PR1201MB2522:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2522960B877ADD260B1BA957DA560@DM5PR1201MB2522.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nwexx4g5m70BYlpX2WmGGoQblwe28XLYu3VruSCVyRYTCyAsV/N1FMTuYFjgr16yB45jGtkDpMVI+0Llku4QuQrqw1I4mKdKJjw4C9O6rvXEJPFubGUz4keEewjJQm+pef7NiTSvY+0SdA0fphD8S2md+8Ns3lWk100DBKR6DOPER62DfbW7AKjudaJ+FS607FOBYBH0o7JsQ/9EC4ym/b0V7klOnOaU81CWJQrzVvbfZJmi6IBKhp1VA/hxfcZJcU86SnFhpQ66Kc7owSbwgzbYjSfO+51bO+oZ3O5AldwY0iSWQZmpuzgGXSFkOygnhHp3WRvyMUEhU5/r5lGNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(6916009)(2906002)(4326008)(86362001)(107886003)(316002)(33656002)(53546011)(6506007)(54906003)(83380400001)(7696005)(9686003)(76116006)(8676002)(26005)(52536014)(64756008)(66446008)(66946007)(66476007)(66556008)(71200400001)(478600001)(5660300002)(186003)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VmxFBWUfCB+gMcK1FDKZcRVAcxNvVdbRyPq88+8DYUQQYnHnXDEjVkGzj7jJ9b7rcqMDDFDhux1JmXzuNe2gxDaEMouhyQ18ukGahaStSGkBclWcLIr7+o2p4XNEKHUbSKhY8NpNAHzAZmJsR/iXqwXOh7k36cXwzPWTCbeqmHO52EhT3ff3tzemEuzAioBXbsiany6ougCeNn5EqxGVulSijKbk69Hr/tmFEF8/cwiyIg2Jej/m6ZfhEKcwt42d2tNaz1+pcR88HitLa2HxJssBIrsuz+DGwy60Y0Jv1GjUjY6QrFuioFWC9CsHN06z18ZpG3lKKmt2kQUMUoGVVRLgt/+xtF1EMqKD7EyHUDcGGEg9xEslP3Ct0uiB1f7lRIXQArdt8CjijLzlITWArX0Oa8uFcYkuIWWZD2rAj59oS+dqlZiMxXdsrDaITNfIvbEOU5hcdj8zVbahXreNrqGnBmACaTasrvmyic1kONiw+Dkxj1jWMl/P/2ME7N1hGo272i8bBM/giJDnTiPfXOOBNNHuNZDBgE7uzDlAW2/9xve4nTq2KTf++NiIppTCIym4O5/wpAl6vqpFdPpTcYpaA3Cdxw8xchgj5KA8VPSd12IeJtEKjXx6SQFVHajXDNIc03pZ9RHt1pRM+T6oPQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2219fb0-cf44-4622-1151-08d8484daa48
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 16:49:27.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHmDS61TvwIDfPUnVrYx6DNwNjiLVjZWKMr3Zk3iXGuBWlWVFOzBQKSvJo9ghwX80a0PU3gGdw6T8TMwWhMFZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2522
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 20, 2020 at 21:59:42, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> On Thu, Aug 13, 2020 at 04:08:50PM +0200, Gustavo Pimentel wrote:
> > Add #defines for the max payload size options. No functional change
> > intended.
> >=20
> > Cc: Joao Pinto <jpinto@synopsys.com>
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  include/uapi/linux/pci_regs.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index f970141..db625bd 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -503,6 +503,12 @@
> >  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting E=
n. */
> >  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
> >  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_128B  0x0000 /* 128 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_256B  0x0020 /* 256 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_512B  0x0040 /* 512 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
>=20
> I would apply this if we actually *used* these anywhere, but I'm not
> sure it's worth adding them just as documentation.

Hi Bjorn,

I'll be using that with a driver that I developed. I didn't send the=20
driver yet, because I'm still waiting for a final validation from a=20
colleague that is on vacation. If you want I can include this patch with=20
the driver patch set.

-Gustavo

>=20
> >  #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
> >  #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
> >  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
> > --=20
> > 2.7.4
> >=20


