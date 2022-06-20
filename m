Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D353155109C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 08:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiFTGnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 02:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbiFTGmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 02:42:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841ACDFFE;
        Sun, 19 Jun 2022 23:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RooMSzPSDNgoVffqi7WRS1x3KLc6sYJu1TthIkRs7PPcggpDOmOWa7/A91p9ecRJaTD7nKTdeT8HKT6IVGsH2/H4heew1MXsYMp+DEpCs6vg3kgWQhBDDAebyjbbZ5Q5behojGFBktF5DR8YoZ4mh1K9jncRJg2h4y9Ropjj6yknAPVwu4ubDqBbbp8Sjx6D6UoqFzHVmaWfKT/zDnelEMhGY5gjageHPBcEO42dUY4d8qIDDheR9pIGohOu0ikauAUhYpuqF5jKUmIzCoRLGZjApp8PznNnrJYtVwE/QYONyW5WrL9X5wzPiLgD0zgtrOzrAeOfLpXf5h9gJuBO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSO7YZQc7vvNr6vJDmPdytdxRXyP2qrHEodpgmohqLc=;
 b=Le3iDq5pHSeLp15GfcY7JZnyLYpnkVmOHoKHyQf2hCTKZK2DoS2h30EYH7TUJHeaMF9BCCO0sfKIrOTyeaQ7hlH8yEx9nwoK6ZgauRgM7576F58m+3jErhBPRUF07//1z0ts9GSEQIWOXimZf8swfgEy/aV0Gf1Qd3vS3MtE/n+PVul9hCO37TL7hijHCJxGkBVdfbpUY6ahA+X5/TB/FJCIXI3z5ySb0Graulgrlb4izdAzmc1C34vPFPqWXRlwFa0OLp3n3M2bqGE3a60HsJUChQ4Cdb5WWCklZbhEtioLbMYSB3X+6sqE7WC91SSCPUebA8hG3czJBB4ISf+ZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSO7YZQc7vvNr6vJDmPdytdxRXyP2qrHEodpgmohqLc=;
 b=tqF84q+CXXL8hl1V3CGg59LcFHM0Mj/Wcg7jrOLywULs6g1b5FCia17IQEB5b1TlVKXUA95JHo9KAjG5bIjLFpbxT9QZQ+Fi4qSon4o31VhNEG6GZCSlRUMhn43deKMnAgIUqVnCVt0oTeXULjE0GtFuJZFZylZj/7jJZJsyRg4=
Received: from MWHPR19CA0020.namprd19.prod.outlook.com (2603:10b6:300:d4::30)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 06:42:38 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::b2) by MWHPR19CA0020.outlook.office365.com
 (2603:10b6:300:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21 via Frontend
 Transport; Mon, 20 Jun 2022 06:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 06:42:38 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 01:42:35 -0500
Message-ID: <a095aae3-7143-e3cd-a73a-3db8a702d794@amd.com>
Date:   Mon, 20 Jun 2022 08:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers
Content-Language: en-US
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>
References: <20220618052022.10388-1-bharat.kumar.gogada@xilinx.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220618052022.10388-1-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64f4f6e2-290d-4d4e-e8a2-08da52881160
X-MS-TrafficTypeDiagnostic: CO6PR12MB5458:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB545854287CFF87F03BF522E888B09@CO6PR12MB5458.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlSzwLiiT97jMFs7+IJjIFbt/q9Sxx8Cr6HMV/JpYftfR96m9t4TWz1ozCFQV2H0SzIvVqzc7equfiJnVza65vTDbyWUSftnnQrq/c4kDie/V6uldPEhF7OARZuvb4kPBJXRpyFMSZ/w3H9zxuVmgnPs5YbUSOWDelCoKieH18/im4AG5UO1vysvrwVTv2LQJLPV3R6Z1YAYE5eMjRfA0XXiIwy3tGSboiRbetsUn7UssI/Gg7qXtrco+dJZgyHuBKG5Fmh+t9oBujMW1RXM/etVIu+ouuCzrRw9Y8zQnSvGBvkxeIljvJedv9+CGHPLgHrlXoc3O+8FH3iJ9zyzOKUu4LQvhLlgrcLL3RpEOk0vAWQcS2GPh37JoGcPxqfKCbmSCIAd7jAD+uMlNeQHG2Y20aAQQPy+l6rVqIvAJNX1/WSZbBEG7KH/rgyORuijfob6lWBE7mewx4/GCBVEDC++ahcbR1y2EcwBP4UIrdzWkMw7Dp3MSPYa9jDMaMfhAup4QryUkVImOPSDQNpIb/+kbHW0ka5V3lQ1Tr/smxvcTSRFDhwidl2Dz2tV5Q28EywkqipfFkvVJXkAAgzReoMlZ5KuRl4pahIdt7ZnthksX5nMyY/GJnl8unTnUz7jxbuO8hoc9ZDJqAqr58SPrhE/f8GeXdQVzkgAKEj8LgSVnX701ScWa33g+kfxTtCWFj3mUr8iSCORBxistIx6I/GZ3ays37UADK7VmLgNPHPbFrWWGl0Y701hbJPNyqJ5kgQj/qirmiZmx0mh5gyE5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(40470700004)(107886003)(2616005)(53546011)(86362001)(6666004)(16576012)(316002)(26005)(2906002)(8936002)(31686004)(41300700001)(82310400005)(44832011)(36756003)(5660300002)(40460700003)(4744005)(40480700001)(110136005)(54906003)(82740400003)(81166007)(31696002)(4326008)(356005)(8676002)(478600001)(36860700001)(16526019)(186003)(70586007)(70206006)(426003)(47076005)(336012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 06:42:38.5065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f4f6e2-290d-4d4e-e8a2-08da52881160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/18/22 07:20, Bharat Kumar Gogada wrote:
> Add maintainer for driver and documentation of Xilinx Versal
> CPM Root Port device.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..a07f926d7e93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15063,6 +15063,14 @@ L:	linux-pci@vger.kernel.org
>   S:	Maintained
>   F:	drivers/pci/controller/dwc/*spear*
>   
> +PCI DRIVER FOR XILINX VERSAL CPM
> +M:	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> +M:	Michal Simek <michal.simek@amd.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +F:	drivers/pci/controller/pcie-xilinx-cpm.c
> +
>   PCMCIA SUBSYSTEM
>   M:	Dominik Brodowski <linux@dominikbrodowski.net>
>   S:	Odd Fixes

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
