Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB4A28C021
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgJLS6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 14:58:48 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:50752
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727115AbgJLS6s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 14:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UunGoPk+alGP5f67JReUDK3fw36Qn2hM0vsWKkyqHfnaBw8cbL8sHJwxWyYWsK+IIP1V1tfU0ZyqHoPJgZXIxhQzJX8w4CFTsfHrE1zmx7+G9H8V2Zdj0hp2oyTN5O1xhwthotPMIG/loJfn8WZMXVlWjK7Z7BQzleSEXflDFK1T1F6lQG0Rzb+ho2HUHB8n4LQ4qFs9n7LH2L9uHJ2Hr2sAbswHo7O1GpeT8C2GtP+2sbm47HyQnX9G93L9fmIvSbNyx7OK8falLq8JpN8felzTnUCdMa/uMSL9701KQfuTaWAyWrq1vpgvTcgnjTG6TioJX+PE9Cu290KO7kM8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1JgePa6dWgLadgXV364vQnwYinKC9qZznKgyx659AQ=;
 b=Ercrp8XlRds6d36t7MTem7sYflguFoUrOTEjeJ22IEMQchDdGXEpPrVF0XdHafM/OZ4CPAZzCwBvameipnZjNDBi4KG+7pQWpXBct57SN6nie4gJnarzSNVpuIVfinGW67anvvx/gM3Ju0EOg96kJTBE6ZM5VnCJKvrfEMI7szIkB0XNg4MxZ3toSFd5L78OQR7gd4s9zi7eQ4if5IDk7DBVt8Q0b3mFbKtJdzaGRTTELFqqVopk74ce8vOhOIddSkJMhjngkLcTM2ftkuzxEKzVrOdGd5aBtzIW7QFxNPhBvpGw6YJf8ZD+gbfCCD0uHT4LKD7S9lWAwZ6epgLpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1JgePa6dWgLadgXV364vQnwYinKC9qZznKgyx659AQ=;
 b=bB3ysUY1eWY8Bql2DzGaOZW1wKub3YXqdxjpHZgXdRAzxNq4cefi78QzraGTyN9tb0YMjMY8pPZew7xObs7DtHTa7AAUQZZqZZHiQjS3YacWB6TSVW1BocJd/RRvQnkKHWoAe81JJAnYHLwpYqkf34E2PLE404wmnxW3qe17Ngk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB3206.namprd11.prod.outlook.com (2603:10b6:a03:78::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Mon, 12 Oct
 2020 18:58:45 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 18:58:45 +0000
Subject: Re: PCI, isolcpus, and irq affinity
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
 <87a6wrqqpf.fsf@nanos.tec.linutronix.de>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com>
Date:   Mon, 12 Oct 2020 12:58:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <87a6wrqqpf.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by BYAPR11CA0085.namprd11.prod.outlook.com (2603:10b6:a03:f4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Mon, 12 Oct 2020 18:58:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f71557cc-987d-455c-580d-08d86ee0d83f
X-MS-TrafficTypeDiagnostic: BYAPR11MB3206:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3206246FECD22DC733872390F6070@BYAPR11MB3206.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7Lh5Koazq5UEbLPvRvwnVvz070Lxvds8w/sEdcvSznoxB3sq1IQUJUW6C0I2D7lxjjFAMuzQuxpMfkZdxW9aMTn5xbY69Fw/jttFjIYcP1yHpqKTqUZrxODVL9HLJv/EZ743l1eJWC2eal0u7Qk0eNP/8Fb3Pe+QS8NonZaP8eV9IidQRR9+c+jSu2fFbt85CdNsa1nl1CQw2zFZYoT8uZeGyT9pHNs6FsO8hEFFl/3CZY/eIb54FXrq/R2JegsLtVNZzjnqJUOe7GHFIB7FbbniVM/iqCCU1Donl00xe67fuUFlvRYc1lW/dVL0CBxLFDffxYmDkW32piz4oELuwXItmqoH73evi0cKITbTM6Wt8HupBYivZzchBi8NN3h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39850400004)(346002)(31696002)(6666004)(52116002)(44832011)(53546011)(66556008)(66476007)(66946007)(2616005)(83380400001)(4744005)(86362001)(16526019)(186003)(26005)(6486002)(5660300002)(8936002)(478600001)(2906002)(36756003)(16576012)(54906003)(31686004)(956004)(316002)(4326008)(110136005)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: p29pKSoafvDET3HxtmJ9o1nZ/7ZfQ1xxmZXFr7rgC/60DJ0xKUPvPiYVLTSIP3ogo1cgO5zk6DQcGXhgj8P8/MSkDDwtd4T1pHg3Xla8feDEP2wMOV5fpL4hwYGVVNJ5BXxDmzQu30ZmYlpQ7SS0dRjsZdB5il2f36XMN+3hAyUf59ETBsz72cJdPSArs2zb7n4gJ9g9DOQPuBnRXHDDVPzjnCdPdQ3kQIJaIQErvbNjHBGkgQXxy0aKoaRU2Dxouru+1skNcGWCeo6sqsIrss06EZ6bxGJMBBb6t56RkT0zL43B6OlAhVUyV3dcyoc9AzoToCTsfTlR1dOeMLXublXyJhNWxqW6bqP/Ieah8RhZ80fh7EJYmuzQscF/1abIDRiKUwAqggpuB5VdQox77z9DURdvns+XSeeLX6zIza0Dd+3tRQGBKYnQSe6CLfkhiymAXZcdPjKM9dRuekKMK+nR8Peg4NL0jhovZWUxat/QMh+D8eFccJgdSa3BOHNz7llu1EK/OT6p5JZbR2qiMqTPhPpSr4FjtTo35wOAgbKYEjhk2DTPqXSVlKYxKrgTw81SSc3CjVr1uz3MU4Lcm+sG/ZIw2b19XYgmQdsJ1mvf0j6p3gLdqu8wnSbLN2+5so+cLXaRPODcSHYpsvNQgw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71557cc-987d-455c-580d-08d86ee0d83f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 18:58:45.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoFDk9lsF+jkAPCD0gMk9KO1jSZZx04zpVjuKpcALlEXRSjlDCm+CW+OASb8ZfPefyWGcvrpCN36PM7L1eJ/EV8802eFDkVmkPdA75FKBR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3206
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2020 11:50 AM, Thomas Gleixner wrote:
> On Mon, Oct 12 2020 at 11:58, Bjorn Helgaas wrote:
>> On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
>>> I've got a linux system running the RT kernel with threaded irqs.  On
>>> startup we affine the various irq threads to the housekeeping CPUs, but I
>>> recently hit a scenario where after some days of uptime we ended up with a
>>> number of NVME irq threads affined to application cores instead (not good
>>> when we're trying to run low-latency applications).
> 
> These threads and the associated interupt vectors are completely
> harmless and fully idle as long as there is nothing on those isolated
> CPUs which does disk I/O.

Some of the irq threads are affined (by the kernel presumably) to 
multiple CPUs (nvme1q2 and nvme0q2 were both affined 0x38000038, a 
couple of other queues were affined 0x1c00001c0).

In this case could disk I/O submitted by one of those CPUs end up 
interrupting another one?

Chris
