Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8791C56A2
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEENVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:21:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728948AbgEENVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 09:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588684904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cJjk1voas+0dvk9PcOEDjKeOiN5/Y1FC1G41w1fjgkU=;
        b=DBugh8bKri67umNv062dIgouMPRbnFVX9GKScV6wrdWd0vAKswl1nZi68AxNdCxCicK+EN
        4IKYU6SoVXf+Dm+hEhEO5sVLUbJIHw/jsOkpk06AcEt1+GjwROYKWQ9zwZPMlbaDggcPB6
        FkHE8hs4m2rWckOGYJXqWnkAeVh973s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-ldwf50YtMyquTXqrm3sR9g-1; Tue, 05 May 2020 09:21:40 -0400
X-MC-Unique: ldwf50YtMyquTXqrm3sR9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BD1010CE784;
        Tue,  5 May 2020 13:21:38 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A748D6060E;
        Tue,  5 May 2020 13:21:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 0/3] ACPI / utils: Add acpi_evaluate_reg() helper
Date:   Tue,  5 May 2020 15:21:25 +0200
Message-Id: <20200505132128.19476-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Here is a small series adding an acpi_evaluate_reg() helper, note
the third patch sits on top of a fix for the pinctrl-cherryview
driver which I recently submitted and which is still finding its
way upstream.

Since this is not urgent (just a small code cleanup) I suggest
that the ACPI people can pick up patches 1-2 and then the last patch
can be merged post 5.8-rc1, at which point all the dependencies for
it should have landed already.

Regards,

Hans

