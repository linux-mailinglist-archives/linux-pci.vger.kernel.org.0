Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF01205B59
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgFWTBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 15:01:38 -0400
Received: from mail-eopbgr130095.outbound.protection.outlook.com ([40.107.13.95]:60643
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733200AbgFWTBi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jun 2020 15:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktg4GWDeNTg8lyFFO6xnMaTptBZZJ4zJO4/LMJ60+MYr4M+sGjeG7GN+bnA7XLONYgmO4D/pzXygrTzGriQ46Vr911PhI2hNSUU8oGwsjJsW12Q9befIhAdxkL6bwiHCQAPWxnRxDJVNw1WliWNfvGdBkrVvIo5yLNskKDlh7YIDof/VES3h9sgT6MyELfrc8AjLsYZ+4OaNugOrQYpx6GqjbMz9IvDnP3hlxbj/oRVFV8LirCNqcezv1YkzMd7RB9TV2MjXFasbeAMI9oLzJR7hrUlAE+QJ5KJNgigYNXYXquLzIBY2SueR5gfo+bzHJ7zy4cELF7v3YTFHNo+MDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnpliP9+F/fX8p4zAR/gG06/5tPDh7GvwOFR4keLz0E=;
 b=R2MSSjS/uy/me1A3/nH5y8F9O/U7jkUn3gIoU11tRUcvoWGTQB5uMn6Q/lJeSbSUz5/mibgE9DdpkNegFF0QKJXn2OElBAg/egBIcGly2kQw/aX8ubAUUvN2BfA53Y3hV2R4S5aloq1ANSEGt9ikwhD1lcGiHAvz9Mf5UYwJFQBMCcsqnyRRyWA8bUW27uBE6ppQptT3C7XGhrzd5MYg3omgduoqldrVwm29VfEH0aMRxINc98+3aB+iHU81BRczW2SfebNXTMtFgkZUTMkT/gZ1DSFIo22IA3jqPrAsTvVLEBapfzjQmbcsHbdXj2Yb2YI5VD8UnmyknYFy/t4SIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnpliP9+F/fX8p4zAR/gG06/5tPDh7GvwOFR4keLz0E=;
 b=HoshDd676q6UfsyP09OxF6lfh6LI049i+SnQ7PTTCycF3LqT1DvWJY01y04/7HJwqK3Ezk1tdNhBCNUu7t3qs8XbW78x2lmu7IXlhFnzU+boqTjfw7KG4lluL55DKa/Ok7Rhamd43EEr36NR45kcXq7buEdZMN8vi5uwv/AnnIE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB5171.eurprd08.prod.outlook.com (2603:10a6:208:159::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 19:01:33 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 19:01:33 +0000
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: lost acpiphp_put_context in
 acpiphp_grab_context()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <CAJZ5v0gQD_T9WmoF4gv-eDpmKto4_c0pJGiy_7FPiipSGOTrQQ@mail.gmail.com>
 <d41ead67-f66d-43fd-7a4c-e4d92adb52f2@virtuozzo.com>
 <7280140.ndZnX9ZZJL@kreacher>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <5c06169c-295d-040b-07e1-823880584bb9@virtuozzo.com>
Date:   Tue, 23 Jun 2020 22:01:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <7280140.ndZnX9ZZJL@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0052.eurprd03.prod.outlook.com (2603:10a6:208::29)
 To AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR03CA0052.eurprd03.prod.outlook.com (2603:10a6:208::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 19:01:32 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86383579-1fa9-4209-2014-08d817a7d88a
X-MS-TrafficTypeDiagnostic: AM0PR08MB5171:
X-Microsoft-Antispam-PRVS: <AM0PR08MB5171BB98ED8939233F4D9E71AA940@AM0PR08MB5171.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQilIaeIA8A9OruvQbWCpsZ9bSpXm2hJipno0mccKk+VL8Hf5BnNhpChEM/lxMQRBlboQU5MiDDP97ojsn9MRRcTCEkYqO1O0HmYDm5hiezroB4h+WzQo5T/tPBsJWjeuFIYZWJbnhJgYJhi2GcFUwKClo7i7QTwnQAdVrDLxCV7laMOsybGHF6LxvqwyK4t7gRXP0BKPmzAb/6/IPjeqHb5jt+uVju0Pb4h1zUvl7WbvBopTWoiu2EM3US6BtCCQPsGnPS2eWL4SaSf0IngVugvWae2xa86CPlIPxDLBa6rZruyCRiAQU1NAd6+yupGtEDpiJhAJCUCBjzrN3FAYA9EXpsiVA4qHmZyi2EvS/kbBXyFx4bZdUHiHOcc4kh4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(66476007)(110136005)(66556008)(83380400001)(31696002)(5660300002)(2616005)(31686004)(956004)(86362001)(2906002)(26005)(53546011)(4326008)(186003)(16526019)(8676002)(52116002)(54906003)(66946007)(478600001)(6486002)(8936002)(36756003)(16576012)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WSzLk65oqKeCk6YZU4TLFWTkVTDsRFh/gQjy+L9S5DoRiBVrJOQr37oojfrfFhMxnvbVjz504yrV5cbZ9pEvxf6nHYrAwkvyJ/cTWlzHyFt53eexL4HsxOjUFRHdLPnhOzv3o7LJ30sVA1yz0uVk0hk4v7wMnVZmTOrT2ilCiFUUcv2kby4l4S1HWtAJtWL7cpZmFpSlG0a2jV2hwhRirjbUHgCN8okMSuJv5w4pdOibObqA5t5lxCTdZbC98MDhJdD/l3qMBqj8LX580Bbi0kpKXQN0QmybVtr2HXTPk3WWCuOjqBDGuiusuUwqcVLj+IMQelXEvlos+Ye3FkDiIpqWRTtFE4S7Yt7bayiuHo72jZwsejAKP6LfOAHI/+aaX6wjidqbaphixYtV5F/qdngj3pFQtEv2NHvRJdeky6rlGAixLD/VJQaMjE/Rvf8glvDeGOFt/S6cR+8sBYb/9CtkdFbgGhFKb8kkZK+B6Qw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86383579-1fa9-4209-2014-08d817a7d88a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 19:01:33.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MhJJc27cdv1mSbV3N0/4b2tnSFASOtYD8/hFDVLxQAdRk2fI5E/+XxxZejVXQye9CphGPtCNfHtlwoo9yXXbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5171
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/23/20 7:29 PM, Rafael J. Wysocki wrote:
> On Tuesday, June 23, 2020 1:17:43 AM CEST Vasily Averin wrote:
>> v2: followed to rafael@'s proposal
>> Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Thanks for following my suggestion, but it occurred to me that it could still be
> done in a better way.
> 
> So instead of the above I'd prefer to apply the following change (added PCI and Bjorn
> for visibility):

Thank you,
however could you please tell me what do you think about following variant?

 drivers/pci/hotplug/acpiphp_glue.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b4c92cee13f8..5875c3654b52 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -119,16 +119,17 @@ static inline void put_bridge(struct acpiphp_bridge *bridge)
 
 static struct acpiphp_context *acpiphp_grab_context(struct acpi_device *adev)
 {
-	struct acpiphp_context *context;
+	struct acpiphp_context *c, *context = NULL;
 
 	acpi_lock_hp_context();
-	context = acpiphp_get_context(adev);
-	if (!context || context->func.parent->is_going_away) {
-		acpi_unlock_hp_context();
-		return NULL;
+	c = acpiphp_get_context(adev);
+	if (c) {
+		if (c->func.parent->is_going_away == false) {
+			get_bridge(c->func.parent);
+			context = c;
+		}
+		acpiphp_put_context(c);
 	}
-	get_bridge(context->func.parent);
-	acpiphp_put_context(context);
 	acpi_unlock_hp_context();
 	return context;
 }
