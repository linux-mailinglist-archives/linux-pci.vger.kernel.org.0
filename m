Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10664359E45
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhDIMGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 08:06:01 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25445 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIMGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 08:06:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1617969043; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cAFQ52Y3aWd6re2msI2y7pjE6Z2OHHrgb2wjoGYA3BycuiLgRMKBMKRRSPhF5Es1MGleYOZYdETaUNZ4iTj8NA2zGpXps08pKrWN9IE86zkH5j4vbC94RuLJh1T94wuHPz4fFOZeL3JMVS6SPJA93Uf5lSmUnTJZdWxVC2FrjFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1617969043; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=KQJLqhWr4z4TkHCANPbJ96wpXshdO3B0VxT6bsUQBT8=; 
        b=e/EOyVJ5vdIR2ofv5dP1xGvJibyc5ZCfSJFPczxg5BmmJ2QhSYJj1n5FkR2C6C1FHmeBpaksAmMzSX/zfeC4jUf29FB3+7lhajbuPLf2JUoUa3WCv4rUXiuR8XMMoGgCaX3LnJvUko+i5CY5wd4AT5j/PDRkGJ27Pg6vHuWU56Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ragasgupta@zoho.com;
        dmarc=pass header.from=<ragasgupta@zoho.com> header.from=<ragasgupta@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=date:from:to:message-id:in-reply-to:references:subject:mime-version:content-type:user-agent; 
  b=uHhrG0uH0qZHfO6V+yK7HD8tyigwQFFd551jzfVh0JDdV5Iyq/k30U2puGgTwxPgrRhk5TpLfTTM
    lUdDHSLj9HMvyKP4f60qJX4vZyMP90EO0ywAu2QeQyvRFNdjTPgA  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1617969043;
        s=zm2020; d=zoho.com; i=ragasgupta@zoho.com;
        h=Date:From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=KQJLqhWr4z4TkHCANPbJ96wpXshdO3B0VxT6bsUQBT8=;
        b=VBaPnGc0Q9fzmyy14QHbA58ldw/QgMO9gmAmXzZi0MIOnxH8038UUiUPHLSnvY6t
        LFJ9K5NgaeSqxLQELdwae7pnPvvH189BS/jBSDzljYQvmlgRwjyBAajcyYSF1PP+LAJ
        YdA2LGqOzUYezqdylsCaPSV00T/27nbUnla6NZ3w=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1617969040367259.9782655721767; Fri, 9 Apr 2021 04:50:40 -0700 (PDT)
Received: from  [34.98.205.117] by mail.zoho.com
        with HTTP;Fri, 9 Apr 2021 04:50:40 -0700 (PDT)
Date:   Fri, 09 Apr 2021 17:20:40 +0530
From:   ragas gupta <ragasgupta@zoho.com>
To:     "linux-pci" <linux-pci@vger.kernel.org>
Message-ID: <178b6784bd7.f1a37c91132657.4038524595161012155@zoho.com>
In-Reply-To: <178b67644d1.107ad1ec3132641.8033434734705028022@zoho.com>
References: <178b641aeb9.ec6e71c9132052.6218745065153370962@zoho.com> <178b67644d1.107ad1ec3132641.8033434734705028022@zoho.com>
Subject: Function Level Reset notification to PCIe device driver
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,=20
 =20
This query is regarding Function level reset feature for SRIOV.=20
As per code in Linux PCIe driver the function level reset is done by writin=
g =E2=80=9C1=E2=80=9D to =E2=80=9Creset=E2=80=9D under sysfs interface.=20
e.g. =E2=80=9Cecho 1 > /sys/bus/pci/devices/<interface id> /reset =E2=80=9C=
=20
=20
As function level reset is not triggered via the PCIe device driver how PCI=
e device driver can get the notification of the function level reset(FLR)?=
=20

