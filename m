Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2492A6406
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgKDMRH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 07:17:07 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:20923 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728645AbgKDMRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 07:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604492222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
        bh=8RRIZtL5bXpJA2yQh2QblZpcfHMZhebZJOplYIlanSQ=;
        b=kaO7t1DdfsKY2/wGdIhUULvOg8UFWmT2isxYwhuCOp6t+UErF/UdNYY4mJcIC4z3S8Noib
        ASxY8JDsTCj7mIylitW6qxqRJvjW+IQJaLJVVeVh/RN0lfBNtfP/NKeD0bLZBNOok14huy
        8OnbA57a6JNwMAa7zfR4eBj6Epl+LgM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-QGo8vGyoPI22QFTMnbU-LQ-1; Wed, 04 Nov 2020 13:17:00 +0100
X-MC-Unique: QGo8vGyoPI22QFTMnbU-LQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C69m4zsi4n+4I/eUZjYRj7kjykpQ43EGYEIOt6XgMZqPXHqTUaZfJXCULC7PGd8aor579xRYOS3PsCEHhPggIfxAzEuSFjxqGVUbID9Qr3woa94XS6QmTGNAr0wdkRnlVekQ1YBAU2fkJp4aiLDwMOJUFjlr73IbHUqqMK3dZev4ovfbvvQGuUTXfBV8J/j1xPdDyA794I0v67fdMWPduJhh8pA1+f2l3c1Ik2jGUT+TZt9ReDXSn41GoAwYRuFIHt+coKxgRRUZKPYfoQJ1BtKG8Ft++OV7u8t4VeRqw6K4vjOkZ69qRCwl7b6rPk2rAVRDkId8yQGNeKWI6OTs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RRIZtL5bXpJA2yQh2QblZpcfHMZhebZJOplYIlanSQ=;
 b=mZVBDk9fTo9mMO8tjizUYLle7rBSH0mYzcXFo8P6EheK/naxV23tKnKhZTNE8wmTMI5X5xZ126OzdQyC2PQNvFZXaj5aWf6zmJE/H6BDdulKrOt0Ql4iKdLTVyjBvzy0+qNUDzoEYnoSEioYojIlv8ysc7sGXHl/sLU+ilvAE7wztomYBmfuK6nM+ecG/XOPVNJr+C+1SBpLZdg7gNDiUFVcOrOId9HIXGU6c0wHaB1XkYlS1E/XN1Cl/err5VxbHiTi8F6WAot9+s3PJ4Dt/1GHiOEPbhL7EsR2nSNs93PtLq1pD13wv+kgxNdzV5d5aIEwZf4kZY3xsMmVNmukgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 12:16:59 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 12:16:58 +0000
To:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
From:   Qu Wenruo <wqu@suse.com>
Subject: v5.10-rc2 kernel unable to initialize RK3399 pcie root complex
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <ff0d9bba-3c24-56e1-b598-ae8dd07cfa10@suse.com>
Date:   Wed, 4 Nov 2020 20:16:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0059.namprd08.prod.outlook.com (2603:10b6:a03:117::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 12:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2148666b-fa43-4f77-155f-08d880bb870e
X-MS-TrafficTypeDiagnostic: PR3PR04MB7323:
X-Microsoft-Antispam-PRVS: <PR3PR04MB7323E4D75E3E5EF6CAF2B2C6D6EF0@PR3PR04MB7323.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q96GyeLCo7HZkIYDeiu12wmNM1Pfuw9zL9XObkDXt1Ws4VvJgfyHlwUXKjRLZb7KnFw+txqaGO/3DATYA4Ap46nytpzMnoJaVVtHfAp8T+nMs4V98xDOtr3oL7aiOD4xyIj+ii+QynEiS1C7uFyMKRO2sgey/f/hPxt10vLRkVM67VtghV+RY/regWYKlKUOaLTMrcuxpaB8DxIntvpvF/vMK62x4gXlcQ8QNQ00Jfq8/FvItnwVBS1QVyed8UlA/7HKYINwTEGDH7tfl9DORZxUC/MhUJgN3A1mf26spDzuVskbEM5lzknrynvwf25RH+sWIJ9AOsLOndGN3pi79aY0vJrARSLWhUwiBKKOlwakf2pszho4jm/tmwzQckCaQNalPcDCPmAQc569aThz/Cd9SMQR7fFD1GEWDp/2YCn73v8ici2qgRjh8Z8lIB184DYyy5nVyzowb9MSshtxXdaHfYCNxR0O/11ht2W+Q7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(136003)(396003)(4744005)(8676002)(31686004)(316002)(52116002)(5660300002)(66946007)(66476007)(2906002)(83380400001)(16576012)(6486002)(66556008)(8936002)(6706004)(86362001)(956004)(478600001)(16526019)(186003)(966005)(2616005)(31696002)(36756003)(26005)(6666004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3ji7bxg2eNwtS1BbgmgKSRVN4rqF1hPeredJojE3UdtD9yjlyyX5TJiY6j+/XSt/y/OEvRGNu4jgYkncytMZfTq2tTvQQHWdrMMVn7fAsiXCiLyA3FwvcdUIVSZDGkdNDbs4V6lFhCpRntkFaIq2wJc2IBlEA5HQylXPUBDC+sKATCfcZ9SVvpYp5CmMxM78Eng6XsZKM6av/HXfkI1y/2yaLKGVA/nlaBO7YkRO6GeHPUvGmR8cAZaxwZagEOJi7kyvY2AkrCA4tPcBxzSPqTNII8hhyoWPDEoCJvGK+oNdzaT+Hcvx+04C6WnG5BQPM8tmEZj/BLKXFnkyxrRY9HD7iJy7SnMvuopkN4H6+WjLvZ2PgV2XNbnKssKIFpfVkoU1bIhusnXIx7HXw/3u3+ge96knDYV6MzdJok+dXIrSGVSetNvtxDWpHmSQPDOwqRmN+10g6uN8c86L1wplARk/KqviYFnq1QM4LFSK5Yazsl9mUzzkXkFfc0/Gi7RQqLgYwQFX4sLH5VaxsZhB30a7IAb/sYu+oMPzXhFlar+wY49bEWZ15jaIxxpBO3U8VvyBLMA2eXEdx5GOCEUNaGWG8BfL+keJ+qS65l0/VEhOe2glKldbd6zZMeOzaik0CpfjrgaJ8GdspJNY8/ulSQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2148666b-fa43-4f77-155f-08d880bb870e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 12:16:58.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVTaaVHHSk/EeWZ8aH7nr+XtylbGPCoJEvS/mn0PNYaW8KxeqHNQMiumkzFvKkKQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Recently I tried to run v5.10-rc2 kernel on my RK3399 board (Rock Pi 4B,
4G ram version), most drivers work, but the PCIE RC of the board fails
to register, without obvious dmesg error.


My previous v5.9 kernel runs pretty fine on that board, and can boot
from root on LVM on NVME device without any problem.

But for v5.10-rc2 kernel, the root complex just refuses to initialize.
Although the rockchip pcie seems to be detected, but no PCIE bus added
at all.

Also tried to add CONFIG_PCI_DEBUG, but still no pci related dmesg
except the rockchip pcie controller trying to initialize.

Manjaro ARM's linux-rc kernel has the same problem too, so it doesn't
seem to be a bug in my kernel config.

For the dmesg extracted from initramfs:
https://gist.github.com/adam900710/0415c1f19c07f65f892eeb848fd8dfbe


Is there any known bug related to pci to cause such problem?

Thanks,
Qu

