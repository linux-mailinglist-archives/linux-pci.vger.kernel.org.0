Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9926853BCB3
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiFBQqc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiFBQqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:46:31 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2064E8;
        Thu,  2 Jun 2022 09:46:30 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-30fdbe7467cso22138367b3.1;
        Thu, 02 Jun 2022 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=v48pnG2l3DW4OPOrjRPoqO44bNZ75GO+I5VRu3byFf4=;
        b=jd67vL8gNQGDRrxFc+veQ+Mp9vWXg3NIZJIrud1GP50t2tnvew5PAmKoYn7Eh7zOz8
         P0kN8ycfO728HIaemHFjliFUh4EZKTN5ODHGwlWoMezJfEPokb1+0RCvUk75HnsOizAQ
         F1RsO6Sw0G3Bt/FkDY0uJrbvOnBLDH8S79qJLkLMk5Au2HXp7YyNB4rkpLHRmXuaYqLV
         jfNtXEsVSnnSQx0fpqyQdqisCSLN+5LVxO54lqlCBj9F4i0vKfvfJR2jyhrDug4GzNIf
         j/jv/fxB+OD6o7XbQVTtg8inuEczF7ndkwMtEQbk/XK6heveyLnmeA2QcjcB0j6fUnSD
         bqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=v48pnG2l3DW4OPOrjRPoqO44bNZ75GO+I5VRu3byFf4=;
        b=n9KPZw0hHmcVDW9ve+9/Yy/eskDNmko3BtByFgocFKiSmlETd+nwFUep6In/j8a7Zz
         Gm7zST19gzh6ewsYRazegJx/6xJMqlu1HMaCfxxMUZEeRa8OBY+hUORVGXG6Fru8Dg5/
         uGLd7Aazw4u49PpvNOq5s3dyZhjXVIYKhYMliGNcdg7diMZN2t1gv0Kzz6mmjbnsf9r5
         7YNyjA2MwFVPvHcwSGOOZ8J1mJuUO9Wm3FEKkBSJxyX5fn/kPtdMJiwNp221EkqofFJd
         o6eGlV8/o+uIXNd/sRKxDNUonO84ycOhgG+DEvV7i7B+ULslKFELHZTlhErwQGCjWzHH
         33iA==
X-Gm-Message-State: AOAM530qasKstr7O/QGT8jQhX7ctkK9e0smLzihpjQbNuHPIR75rTIYz
        JFiolFXjzEjgEzEYXyti3lwOU9tEUNMEct69uwU=
X-Google-Smtp-Source: ABdhPJzZLwbfOVVpsEW0mkvB+lROwtV2O9r0GW22vMfMdHvdctDB5l6BeOJeP6YueHkxYD1EkzHNQ0S5X1t0QRViBuA=
X-Received: by 2002:a81:47d4:0:b0:2ff:c3d1:c158 with SMTP id
 u203-20020a8147d4000000b002ffc3d1c158mr6487227ywa.388.1654188389901; Thu, 02
 Jun 2022 09:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <bug-216059-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216059-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Thu, 2 Jun 2022 11:46:18 -0500
Message-ID: <CABhMZUXf1hD-phj5p2BB62WC9eK9SRZUOutsfSinUKf_bWCC2g@mail.gmail.com>
Subject: Fwd: [Bug 216059] New: Scsi host number of Adaptec RAID controller
 changes upon a PCIe hotplug and re-insert
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        sagar.biradar@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From bugzilla.  Reported against PCI, but I think the SCSI host number
is determined by SCSI, not by PCI, so I don't see a PCI issue here.

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Thu, Jun 2, 2022 at 1:53 AM
Subject: [Bug 216059] New: Scsi host number of Adaptec RAID controller
changes upon a PCIe hotplug and re-insert
To: <bjorn@helgaas.com>


https://bugzilla.kernel.org/show_bug.cgi?id=3D216059

            Bug ID: 216059
           Summary: Scsi host number of Adaptec RAID controller changes
                    upon a PCIe hotplug and re-insert
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.18.11
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: sagar.biradar@microchip.com
        Regression: No

Created attachment 301088
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301088&action=3Dedit
The attachments contain the log files which capture before and after cases =
for
a hotplug host number change

Summary:
This issue talks of the smartpqi driver for Adaptec controller, PCIe hotplu=
g
and the corresponding SCSI host number


The Linux message log shows the host number (e.g. [14:2:0:0] storage -
/dev/sg27) unexpectedly changing when PCIe hot remove is rapidly followed b=
y
PCIe hot add. The problem appears when the two PCIe events occur in quick
succession (i.e. less than 2 minutes). Because of the timing factor, the is=
sue
can appear to be intermittent. The problem has been root caused as a kernel
issue.



Investigation:
Kernel (4.18.11-hotplug-patch) debug prints were added in  the =E2=80=9Cscs=
i_add_host(
)=E2=80=9D and =E2=80=9Cscsi_remove_host ( )=E2=80=9D routines. Per the deb=
ug prints in the log, the
scsi host number is released after the PCIe hot add event, which forces the
kernel use a different host number.

(debug prints)
Line 48: [ 1811.461055] smartpqi 0000:b3:00.0: Debuggg . . .
pqi_unregister_scsi function, before scsi_remove_host, shost->host_num=3D14
//smartpqi requests host num 14 to be removed
Line 83: [ 2012.125750]  (null): Debuggg . . shost->host_no before dev_set_=
name
=3D host15
Line 84: [ 2012.126709] smartpqi 0000:b3:00.0: Debuggg . . . before
scsi_add_host, shost->host_num=3D15 //upon hot add, kernel allocates host n=
umber
15, it should be 14
Line 132: [ 2014.181784] scsi host14: Debuggg . . in scsi_host_dev_release
function shost_host_no to be removed =3D 14 //kernel finally frees host num=
ber
14, but it=E2=80=99s too late



Conclusion:
The kernel is not releasing the host number immediately when the smartpqi
driver calls the scsi_remove_host() routine. If the PCIe cable is added bac=
k
within 2 minutes, the kernel can unexpectedly return a different host numbe=
r.
This can lead to applications accessing the wrong device.
This is a Linux kernel issue and we will be raising a bugzilla on the linux
kernel.



Questions:
Will this be a problem for Amazon? (Wouldn=E2=80=99t they take several minu=
tes to do
this, they have to be very careful when hot plugging?)
Do we need to consider other customers that might use PCIe hot plug in the
future?
The problem is observed in kernel V4.18.11, but would V5.04/V5.10 make a
difference (should we test it ourselves)?



Consequence:
Application accesses wrong device. Rebooting system may still result in wro=
ng
host number.

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.
