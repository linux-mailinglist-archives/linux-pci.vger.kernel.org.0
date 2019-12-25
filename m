Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50812A6A4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2019 08:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfLYHxE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Dec 2019 02:53:04 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:51195 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfLYHxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Dec 2019 02:53:04 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 02:53:02 EST
IronPort-SDR: d2ezYg6bLqWonddT7bDtVSbarO2QW4tQRCw/YvIMfCcFKTE/8vmU+lHW3rydPstoIce9yXBTuC
 zTfId+MzesVA==
IronPort-PHdr: =?us-ascii?q?9a23=3Ax4JGxhP1vY4Y5xt6Bbcl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0IvzzrarrMEGX3/hxlliBBdydt6sfzbCM6Ou+BCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngu6oRvfu8UZgIZvKrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyoBKjU38nzYitZogaxVoByhvQJxzY3Jbo6aKPVwcbjQfc8YSG?=
 =?us-ascii?q?VdQspdSzBNDp26YoASD+QBJ+FYr4zlqlUItxS1GBOiBPnuyj9Nh3/2waw60/?=
 =?us-ascii?q?o7Hgrb2wEgA88OsHDIo9X0KagdS/u1wbLNzTrZbvNW3S3x6JTWfRAlv/6MRa?=
 =?us-ascii?q?h/ftbLxUk3CwPIl1OdopHmMTONzukBrXWX4uh6We6yhWMrtxt9riagy8s2hI?=
 =?us-ascii?q?TEhoQYwU3e+ypj2oY6P9i4RVZ+Yd6jDZRfqTmXN5BzQsM+W2Fovzs6yqEetZ?=
 =?us-ascii?q?67YicKzJMnygbaa/OdcoiI5gjjW/iVITtki39pYqy/hxGv/ke6xO38Uc+030?=
 =?us-ascii?q?hQoiVbidnArnEN1xrN5cibUvZx4Fqt1DSV2wzO5OxIPVo4mbTUJpI7zLM9lo?=
 =?us-ascii?q?IfsUHZES/3nEX2grWWdkIh+uWw9+Tnf7HmqYOdN4BpkA7+Kb8jmsmlDuQ5Ng?=
 =?us-ascii?q?gCRXSb9vq41LL95U32WqlFgucukqnFqJzaP9gUpralAw9J1YYu8xK/Dzag0N?=
 =?us-ascii?q?QFkngLNUpFdw6Gj4XyJVHOL+73De2lj1Svjjhr3fbGMaPlApnXKXjDirjhLv?=
 =?us-ascii?q?5B7BtYyQwu3ZVH7JN8FL4MOrTwV1X3udieCQU2YDa52+L2NNIo8opWYXiOB6?=
 =?us-ascii?q?6FMb3b+QuM7/o1IuyNeI4LsTvmA+oi5/nrhH4931IAK/qHx5wSPVSxVsx8Ik?=
 =?us-ascii?q?CYfXvyi59VDXoOtQsyRffCjVSDVXhPanK/R6s3oCknXtH1RbzfT5yg1eTSlB?=
 =?us-ascii?q?ywGYdbMzhL?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GEKgC5EwNelyMYgtllgkQBGAEBgns?=
 =?us-ascii?q?3GyASk0JUBnUdihKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECEAEBAQEBCBYGhXNCAQwBgWsihBeBA4EsgwOCUymtExoChSO?=
 =?us-ascii?q?EdIE2AYwYGnmBB4FEgjKFAgESAWyFIQSNRSGIS2GXfoI+BJYwDYIpAYw4A4J?=
 =?us-ascii?q?UiRGnIoI3VYELgQpxTTiBchmBHU8YDY0sji1AgRYQAk+FQIdcgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GEKgC5EwNelyMYgtllgkQBGAEBgns3GyASk0JUBnUdi?=
 =?us-ascii?q?hKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQUBAQEBAQUEAQECE?=
 =?us-ascii?q?AEBAQEBCBYGhXNCAQwBgWsihBeBA4EsgwOCUymtExoChSOEdIE2AYwYGnmBB?=
 =?us-ascii?q?4FEgjKFAgESAWyFIQSNRSGIS2GXfoI+BJYwDYIpAYw4A4JUiRGnIoI3VYELg?=
 =?us-ascii?q?QpxTTiBchmBHU8YDY0sji1AgRYQAk+FQIdcgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="298576582"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 25 Dec 2019 08:47:59 +0100
Received: (qmail 32227 invoked from network); 25 Dec 2019 04:33:51 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-pci@vger.kernel.org>; 25 Dec 2019 04:33:51 -0000
Date:   Wed, 25 Dec 2019 05:33:42 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-pci@vger.kernel.org
Message-ID: <24395006.259377.1577248423089.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

