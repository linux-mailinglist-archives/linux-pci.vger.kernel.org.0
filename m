Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C125C3FC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgICPCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 11:02:01 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:52288
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729480AbgICPB4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 11:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6c90p/C39jHrnbhE8tHIRJwndgHLwznvLnWk4O9B7dvLLj8sT5Z3m8utDBX2D5dbZ9oYzuflcoTIG82Rt4jfHzAJM3HsKevcqI6a4BUSCuOAU5WQu8S9GNzenrgxoRGhDELg4NnyVCT4sxkI1ERUN4Ps2vuYobMeJ4lwzGeAzuLRwGYraW1ejnaAXP9yCQAoLReLka5UFZOSVci0YKTEMQhLLKG6DTyHKsQdxZ/UGKiTVW2uCQOytsnMC9HynDHm/9YqgkrjI/k5b1bly0WePT4FWuHarnY/d/F5NKilF77u9SE8CX0vSID4VUK72fcPyFJWOb6C37kwK1s6DX4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgVVu+A4mc4JGH/iWGSH7SKqt/rSDypsbby8dmnYGGU=;
 b=OZ8KjVyOnUn1Z1JR/ePQp2Bf++S44yVF2pkNU2JtPsIRKaUuBRcN+8HLxmE2i/TlEwqzUQeUsr8SWSUytQy/HcgWc8zbDOvCfClxcnDixeDdfp9enFQnWsqKL+7KcbCXrldxRQvvBKJ3k4Y8+lXgzCc5qnO5Hi8YHMNECPj5b64lp5ajHcsqsZXhClp4Lcm2lgI+JV/A03RqC3uT5oKW5SHryZmZJr093YKiPzXywughg3MHvxF2oWFdE80CLIbntENSNpGM9Wwuj4zx8EHrn/xdhvrpIDFmDrJZk6uZigkp7ahEDdmhxZMO2FSCYGBEoqrVB5xG3/9cujJ1tGN9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgVVu+A4mc4JGH/iWGSH7SKqt/rSDypsbby8dmnYGGU=;
 b=BauQ7Or+d8uLkgTxhpZJOeC5SlF9X9mrlOHvv83u4+hjNw1ERZEJakgMw8M0FUGv183mbadHYQPZgLYQ6HkLdYdNHsmILR5VZREOLIUWqUIYx+Rt1hUU7XcwgbDh5x2o8FCiju01awV3A6PlCHN1IAkKp7xUvi/m8OXlsl39QLc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 15:01:53 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 15:01:53 +0000
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Das, Nirmoy" <Nirmoy.Das@amd.com>,
        "Li, Dennis" <Dennis.Li@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
References: <20200903004153.GA277699@bjorn-Precision-5520>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <b44ce880-bbd9-1258-bc54-3b47d798882b@amd.com>
Date:   Thu, 3 Sep 2020 11:01:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200903004153.GA277699@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 15:01:53 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 115f8690-d437-4ac7-c8dc-08d8501a4b47
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1338CE020C716C4BBBCC0345EA2C0@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OY11hzIAkio1n7uuPZFbl50OmZQ0AbAmWsiip1GGJrwBdkn9AfR+tYjYcpUUsGX5SsaM70omOln7YcJGN8uZq4CXzpm3TCOGzbqnAZWPZ+AylfU9FaQwJCjSx9Hxk6BDnz3tMisfdbvkl3wWfCtRYEuNpdz8xip2GuGR/uTIZ6AOXmDMatnMbTN3mQa5zBJfauR6H539Gc2OSP1I/soDmd6B4F3ob0DqzD+Nkeyo8ZgeWsK9KIUonhuUdXWjvdjnYV6jqznzP82r1R8CyvrK4HgaTv7E+psb5DRrVzmmyKcoSb+5w3U8q2vHVaHMOQ6AI45dPZXJBXVl/EVO9y0bcSTYZSq375p7o84gg6kg0GIlko54BqnPyNe1z76GlIyWYkcRC+0nf0R2VKN7b+R3qlClzRmezRkUdvpTg85dSBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4340.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(16576012)(53546011)(186003)(4326008)(966005)(66946007)(31686004)(66556008)(26005)(5660300002)(6486002)(86362001)(66476007)(6916009)(956004)(2906002)(4744005)(36756003)(83380400001)(2616005)(54906003)(478600001)(316002)(8936002)(8676002)(52116002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: I/9AErA3wWK1LNIo0vVN1MDaJs4UCtKXTL0hnAGgdFA98XeO0FY4mn4soC//hSvKwrqoO75hZRRdFtrzkWl8mO6luK6sWXFO+/OsgH3YHLjHuTVySO8CDzI5w0VJsQco5MUURManphhj6rV3TC5gazFcRC2f7Cws8YgK+PIrMMufeBIggOuzy7moxMTSqwR6S18McqXsfYwf6bYlCDZ+f7NIIwwYeTOO2tRY5gD+rIlaJ1fIzOYYWIZCnODSgfbbLND+UckvcjPzJ5J2qiUFyfjfj1Kj/vN832O/f1gRctn6kZHtVOYXLOCe/QyGlgBEs5KWH5hsjqhHEYiB5QKAladG+4n91rZ6nCvPUVUoH9wVVnOS/rjAfLCiqfE4r2I6iF25FrLMFjnnIyqKWgEOAcu+uEh2o7uNdOOotSN/BLjJY/MPlppbbCg+U1JMzuaPk/B6PIDyaBkA6X7JWi4uvW29GcFAGBOmekz0T6taq155USXhhH1vVZQ/omKRuquH4mfiOKjG6qnlL+ja3Or4JXT7QOEiB540UGSg7c7pIQbWrZxwpTDehJNkZGruu/hJNdNNWZxm8l0r1rEDEnIKTDktXU3dQzk71quOrzhdjaSG5O1a7hEipVf2zbOu+e4s3St4Z/T86e24+eGds8eZYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115f8690-d437-4ac7-c8dc-08d8501a4b47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:01:53.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XOBYqfWhXwfl6TGjb1+X+3ucSc8PyuZXKNJajljz92IkQehdk3EGOzL9FvBmGvsYqMhS0/vhAGesM/8S4BO7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This one is very close - 
https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next

Andrey

On 9/2/20 8:41 PM, Bjorn Helgaas wrote:
> On Wed, Sep 02, 2020 at 11:43:41PM +0000, Grodzovsky, Andrey wrote:
>> It's based on v5.9-rc2 but won't apply cleanly since there is a
>> significant amount of amd-staging-drm-next patches which this was
>> applied on top of.
> Is there a git branch published somewhere?  It'd be nice to be able to
> see the whole thing, including the bits that this depends on from
> amd-staging-drm-next.
