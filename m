Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A2486833
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 18:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiAFROI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 12:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241601AbiAFROG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 12:14:06 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C9EC061245
        for <linux-pci@vger.kernel.org>; Thu,  6 Jan 2022 09:14:05 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id g13so5127103ljj.10
        for <linux-pci@vger.kernel.org>; Thu, 06 Jan 2022 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=s2ZXlWYt++eS6MTGdhy6IiBXqZ6aaRHDf+PLaLkIcoQ=;
        b=eYlRx+VRDwoLeftb5dPJ4A4xMIGxNlysHX5BhIBD3xOAOx6rwbnwyUMj6Jeo9xMdku
         MUVBaH0zaWLxf+4lsOQpIFKfXbNpKjL8fCQcziijHBoXHvOmFTrT6hxq4tht3oFR4njl
         k5LGe5BNbmRx00u+UGhcrXq0WaT2Q+cCGptbIETDB6xupE4SqP9gbXdK+Pk73C9Ldw0i
         odLCEcH6IT7m9kB8FlFjAgV514xvA6xWju62rkC08nTUPEMdtF2Fb+CtfDQmuWsmB+WO
         mbyU3h8SAZ8SDmJtnlM+UsuVaBhr6gbH4omTHp1ct681zcwHn/SrkxEH7+tmzFYeSHgK
         OpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s2ZXlWYt++eS6MTGdhy6IiBXqZ6aaRHDf+PLaLkIcoQ=;
        b=EjbSn1wYPLwOHIpv3tHFnFyUs3PKUDx+gYT83Rh35okeqq6PTz9HfbwM13PFYxh/uz
         HoOWMO6c0Bao2MiwLPJxIeBVQzqWHWI2EgnXGwOBc+q6LRheG4qWlmOG/5rz6tOohrxS
         tYk0BXsl9sAU0irm7pDDMW+VdkLh3n5vYJu5y17NuXs2cIgEKM90YKxj+iwtvulI9f14
         mx+QQRI7kGgOoMhc6pgnzM+4Kcm6CBHi0cveF1USOXzl9DUL0PPICkjpMvWk4+Z7VR/A
         nrfVcF+fUQ+XP82Ww7h5y2T3Va5nkyEFPJ0T7zbtAP4fk/RD3PK/jM7rTphO+S61iQAf
         JKqw==
X-Gm-Message-State: AOAM5318T2ffTgMfDTYEcKwPASb5xJRL5cwPzTAVF8ovdOVHUKD/9cjK
        EIhkM3cQ3z1rPWjS3CqR2m8PO0WF9FGacpiaheQuLms3+vw=
X-Google-Smtp-Source: ABdhPJwcOp/ScGYJa9Njfzk6Bie5jHWa7+A4c2/XTwt5JKrpTkBOl6KGc2cxGa+RVfj9VmbefmSA4KSeOvxJa8hMIAk=
X-Received: by 2002:a05:651c:4d1:: with SMTP id e17mr17907602lji.199.1641489243802;
 Thu, 06 Jan 2022 09:14:03 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Thu, 6 Jan 2022 22:43:52 +0530
Message-ID: <CAHhAz+jFFqD=M=F8y6V_M1f6HDnBnzZDhOJt-G-pzWLHC4idFA@mail.gmail.com>
Subject: PCIe: readl()
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

We have a free-running counter on x86 PCIe bus and plan to use it as a
clocksource. The 'read' field of the clocksource structure reads from
this free-running counter and returns this value.

Since PCIe reads are synchronous, is it safe to use readl() API to
read this free-running counter value in struct clocksource.read()? If
not, what's the best way to read the counter value from the struct
clocksource read field?

Is there any other faster method to read from PCIe device memory?


-- 
Thanks,
Sekhar
