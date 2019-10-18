Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB10DBD9A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504316AbfJRGUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 02:20:32 -0400
Received: from mail-eopbgr810072.outbound.protection.outlook.com ([40.107.81.72]:23639
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504133AbfJRGUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 02:20:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVu4PIVrUMvpsmjPdQUhGbHdQlAxuGC5tzTB0Wrp6vsjHQg8iw2/c419reIvuhefBuvZphOg33NdbT9KQX0/tErLeE+F+8624Llo1vdo1AJScMm7bqfIfmU+k5rh74QhZCAq45M+kjJdb0PiR+4d/WfOKdL/K0PuyuWJrhUCvDMtDdyyiyJxQFwXoEF1f7z12FBCEzWDHjfxVL3nDD0qeB++idvt+dDT5PNgCz1mM6Q70F1uLNkSc4aqwKzA5o66CgQF8ERNRi4h/Y23R69jmsry8/s+n2Qwzm+HeTtqiibIwLk9Wo1LG0Oaw8vt3pYxpxDUjOPDj9RDCbR5cRxVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJMnugmn9lY1GyY1L9mzZ+Gx9W/C+bvit5AS/LW60NM=;
 b=IbupMxOzvFKOx5lO8KQOcep2vNZqGtqwjhDLtiiz9EYW1GXanlu2iiFjYzEW7fPoZjtpQlOvgFnSsdAgzrrude1NDjVoVAncBIPfwS1y8o4jI2jjBJ06Mu/DeGhmrzEA+oF/6nmbh6iHehJdNgZ4+XXc01zCcWpUByl9j3xJnatcsfUIQHnLpOUrO0hJ7GDyq0D0j4Azwwho7Exz/5XYyk8IZET9/bmrVjRkX67nYvZ3eEULiJMAjg8ld2b0R6Wxcw1R8UM+MtS69w1KenZcspbuxXILu9laEXqLeZFA0mIappM5XvdC2Gzrj4NA2MHDsOf3txjicKGtRRwkX9NFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=sifive.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJMnugmn9lY1GyY1L9mzZ+Gx9W/C+bvit5AS/LW60NM=;
 b=pleO0mhHcKFl9Th7N3TCUz0ptwepnbvvtkZswBPzStbrgofXXtdEpKB2u7u3ldPaprhUmTiLWOrOikG4/9yCzjE1vDMMQQZiLAGCO399vDrRAacTf0gouB1yi0oIxO/Xa9jTxXUBOO7V6IDiWjt+Jt5R8FBsSxZvjs2tEeOnsGw=
Received: from SN4PR0201CA0002.namprd02.prod.outlook.com
 (2603:10b6:803:2b::12) by BL0PR02MB3700.namprd02.prod.outlook.com
 (2603:10b6:207:4a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 18 Oct
 2019 06:20:28 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by SN4PR0201CA0002.outlook.office365.com
 (2603:10b6:803:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18 via Frontend
 Transport; Fri, 18 Oct 2019 06:20:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Fri, 18 Oct 2019 06:20:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iLLch-0004D7-NI; Thu, 17 Oct 2019 23:20:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iLLcc-0002dq-JT; Thu, 17 Oct 2019 23:20:22 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9I6KG4u017760;
        Thu, 17 Oct 2019 23:20:17 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iLLcW-0002HF-Ed; Thu, 17 Oct 2019 23:20:16 -0700
Subject: Re: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
To:     Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
References: <20191017181937.7004-1-palmer@sifive.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <995f625b-1f56-6d97-ba99-9a4298e9dd37@xilinx.com>
Date:   Fri, 18 Oct 2019 08:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017181937.7004-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(6246003)(11346002)(2616005)(126002)(5660300002)(65806001)(186003)(65956001)(8936002)(229853002)(23676004)(31696002)(446003)(26005)(76176011)(426003)(336012)(2486003)(9786002)(476003)(966005)(478600001)(486006)(44832011)(31686004)(230700001)(7416002)(4326008)(2906002)(106002)(47776003)(305945005)(50466002)(356004)(6666004)(58126008)(4744005)(110136005)(36386004)(70206006)(316002)(70586007)(8676002)(81166006)(81156014)(6306002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3700;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a93dbf3d-8800-4096-75d7-08d753934536
X-MS-TrafficTypeDiagnostic: BL0PR02MB3700:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BL0PR02MB37005E1A6C767D4C8C55E0E0C66C0@BL0PR02MB3700.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01949FE337
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcMFSbqHT+mqW0iGLxROaHPNSIofx+sEzp7jYBtiR919pjUprvMVY7n3oQYpmAXV11YAXKthQdL9T6ZJVk+RxFy4c2nal8Zzr9S+Plh0pBzqnnpZ/TdniJM4VagLL8nLNGsSM+IB7x92Q/GK7y3XI578GXsC2y2N417uqkKkUMRbY++wL3gGMxGGhLw0u1u3DumQxZ7s1I5MAxiy+MrUXXsLk7g/TnFMjPsACUUuuwmhq0yxvV5+vAuKPB/UJLi35tj9FfNhlKPVnEvO54C1cOYW8bgfZCp//W6zI2hUIklDWBHrcKFmT/sDg4x6rXld35WbMLf5MCsQFRlU4VJGDRvRMW9ugplG7R3i6RlWD3qLYmHgtuscNebHqJzrNrCVcNBSExPyoNeV8NKUsWS6zodZvIH07oNxo4OWL9xsSWHXHink7DnzSLA7skZPcfjL8yVk9HS+245/QxVkkQycpA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 06:20:28.1578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93dbf3d-8800-4096-75d7-08d753934536
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3700
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 17. 10. 19 20:19, Palmer Dabbelt wrote:
> This came up in the context of the microblaze port, where a patch was
> recently posted to extend the whitelist.

I hoped you were aware about this discussion we have with Christoph.
https://lkml.org/lkml/2019/10/8/682

It means 1/3 and 2/3 should be replaced by mandatory-y and I expect
msi.h can be removed from architecture Kbuild too.

Thanks,
Michal


