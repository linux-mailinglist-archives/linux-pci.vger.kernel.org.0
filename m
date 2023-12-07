Return-Path: <linux-pci+bounces-616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D743808987
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 14:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC691C20B14
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16040C09;
	Thu,  7 Dec 2023 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fEQmh4R4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C010CA
	for <linux-pci@vger.kernel.org>; Thu,  7 Dec 2023 05:53:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332f90a375eso962665f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 07 Dec 2023 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701957222; x=1702562022; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VCfngSAlIwqEXssY2pmSdDNSAL/XaZG/lzXesXtgYIo=;
        b=fEQmh4R4RmIcaXkrvGb81zl9JmU+y4xrzTgeCBuXAIkdHKWin9WLJB/n/viKDwg3dP
         bIUXx3ckTE2mJsUklM5rh+7o0JQ59CezeOXIRXAIkfZ7P7+UmPUcTFVRqdHGUS4W8L8z
         2ISyf15P8mOFav6Ua5AFQBUXsSyWs8iYH53kPOyjPYZPVMYL9OXZt/iAPxxHM9o/zgQ7
         l7YqiJ/0s9tVIJTMlTWW361NuOYBYCBVfP13wFODVPw+nQH3njnplGvuAXDp9Z4aw2pc
         CQUM8LgzQe996Rb0F6R2/M4lNRlaxT2lgznJiiCmSEIR8JCAQdtlKWHZg6BnwuhUH1M7
         M0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957222; x=1702562022;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCfngSAlIwqEXssY2pmSdDNSAL/XaZG/lzXesXtgYIo=;
        b=pQ+ejdCU4kC0RkcyuTA29JUbQS6bOV8xlsQ+SBw5fdgQy4HbQC0XWdX/r0EZbfi07e
         hQmd9n0gbJu3n4N5GXtjl2+JxhCSxtjcZhB1ArPTpM0NhwUyb3dK+3YeiljDBOVp7Mc2
         p4dihp++CEmbZNoZhqCukzvAwy7MpKE+qocZav0WbMNMtaIF2kTd01El33BERsEI5knd
         sKN8J88ZeOHc0cAs7QmbB9ywx/sVzgVpzn8YSFbwevnwAh/D4q0dISE9V3iXWCD+tZmN
         ivp1uKT15EWyloHHCqrVFxeYvgsvw9BRY95yTghQa8DL4eKyHwjwGUtq3j2aeh+P8AuW
         bJTw==
X-Gm-Message-State: AOJu0YyyZ3Ln36RUl6CjdiXPom2DtthClq7S/xC+6mEnXuwL7/n8RPyS
	a1p3UqTUuRfPLQqL7v694By63A==
X-Google-Smtp-Source: AGHT+IHfIhZ9GGAZ8MfZ3L3Ia3csFxydF02wtcAFIuRc7oZemDBZE6mMuWwcwbCzPvAhz1n0wfu+/A==
X-Received: by 2002:adf:f50d:0:b0:333:6435:a0e9 with SMTP id q13-20020adff50d000000b003336435a0e9mr1633119wro.79.1701957222529;
        Thu, 07 Dec 2023 05:53:42 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id w8-20020adfcd08000000b003334675634bsm1509505wrm.29.2023.12.07.05.53.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 05:53:42 -0800 (PST)
From: Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Thu, 7 Dec 2023 14:53:43 +0100 (CET)
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, benjamin.tissoires@redhat.com, 
    linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
    Jian Hui Lee <jianhui.lee@canonical.com>, Even Xu <even.xu@intel.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
In-Reply-To: <6776742e5aba8f9f10c661a7876eb252f4ac7745.camel@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2312071453340.29220@cbobk.fhfr.pm>
References: <20231108121940.288005-1-kai.heng.feng@canonical.com> <6776742e5aba8f9f10c661a7876eb252f4ac7745.camel@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Dec 2023, srinivas pandruvada wrote:

> On Wed, 2023-11-08 at 14:19 +0200, Kai-Heng Feng wrote:
> > Since PCI core and ACPI core already handles PCI PME wake and GPE
> > wake
> > when the device has wakeup capability, use device_init_wakeup() to
> > let
> > them do the wakeup setting work.
> > 
> > Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> > PCI and ACPI set OOB wakeup for S5.
> > 
> > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks, applied.

-- 
Jiri Kosina
SUSE Labs


